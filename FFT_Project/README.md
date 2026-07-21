# Real-Time FFT Frequency Spectrum Analysis (Verilog)

Hệ thống xử lý phổ tần số thời gian thực sử dụng thuật toán Fast Fourier Transform (FFT) viết bằng ngôn ngữ Verilog HDL, thiết kế tối ưu cho các ứng dụng phần cứng FPGA.

---

## 1. Sơ đồ khối tổng quát

*(Bạn có thể chụp ảnh sơ đồ khối mô phỏng/sơ đồ thiết kế của bạn rồi kéo thả vào đây, hoặc dùng cú pháp sơ đồ dưới đây)*


## 2. Mục lục các module (Module Index)

| # | Module | File | Vai trò |
|---|--------|------|---------|
| 1 | `fft_16pt` | `fft_16pt.v` | Module chính thực hiện thuật toán FFT 16 điểm |
| 2 | `simple_fft` | `simple_fft.v` | Phiên bản FFT cơ bản dùng để đối chiếu, thử nghiệm |
| 3 | `tb_fft_16pt` | `tb_fft_16pt.v` | Testbench mô phỏng kiểm tra module `fft_16pt` |
| 4 | `tb_simple_fft` | `tb_simple_fft.v` | Testbench kiểm tra module `simple_fft` |
| 5 | `tb_fft_mixed` | `tb_fft_mixed.v` | Testbench kiểm tra tích hợp hệ thống và các trường hợp hỗn hợp |

## 3. Chi tiết chân tín hiệu I/O từng module

### 3.1 `fft_16pt`
Module tính toán FFT 16 điểm chính của hệ thống.

| Chân | Hướng | Bit-width | Mô tả |
|------|-------|-----------|-------|
| `clk` | input | 1 | Clock hệ thống |
| `rst_n` | input | 1 | Reset tích cực mức thấp |
| `start` | input | 1 | Xung kích hoạt bắt đầu tính toán FFT |
| `din_real` | input | 16 | Phần thực của tín hiệu ngõ vào |
| `din_imag` | input | 16 | Phần ảo của tín hiệu ngõ vào |
| `done` | output | 1 | Xung báo hiệu quá trình biến đổi FFT đã hoàn tất |
| `dout_real` | output | 16 | Phần thực của kết quả phổ ngõ ra |
| `dout_imag` | output | 16 | Phần ảo của kết quả phổ ngõ ra |

---

### 3.2 `simple_fft`
Module FFT phiên bản đơn giản dùng cho việc kiểm tra nhanh thuật toán cơ bản.

| Chân | Hướng | Bit-width | Mô tả |
|------|-------|-----------|-------|
| `clk` | input | 1 | Clock hệ thống |
| `rst_n` | input | 1 | Reset tích cực mức thấp |
| `start` | input | 1 | Xung bắt đầu xử lý |
| `din` | input | 16 | Dữ liệu ngõ vào |
| `done` | output | 1 | Báo hoàn tất |
| `dout` | output | 16 | Dữ liệu phổ ngõ ra |
---

## 4. Luồng hoạt động của hệ thống (Flow of Operation)

Quá trình xử lý tín hiệu từ miền thời gian sang miền tần số trong phần cứng diễn ra tuần tự qua các bước sau:

1. **Khởi tạo và Reset:** 
   * Tín hiệu `rst_n` được kéo xuống mức thấp (`0`) để xóa sạch toàn bộ dữ liệu trong các thanh ghi nội của module `fft_16pt`. Sau đó, `rst_n` được đưa lên mức cao (`1`) để hệ thống sẵn sàng hoạt động.
2. **Kích hoạt và Nạp dữ liệu:** 
   * Người dùng/Testbench bật xung `start = 1` đồng thời bơm lần lượt 16 mẫu dữ liệu miền thời gian (gồm phần thực `din_real` và phần ảo `din_imag`) vào mạch qua từng nhịp xung nhịp (`clk`).
3. **Xử lý qua các tầng phần cứng (Pipeline Processing):** 
   * Dữ liệu sau khi nạp sẽ đi qua mạch đảo bit (Bit-Reversal) để sắp xếp lại trật tự.
   * Tiếp tục luân chuyển qua **4 tầng bướm (Butterfly Stages)** để thực hiện các phép toán cộng, trừ số phức và nhân hệ số xoay ($W_N$).
4. **Trích xuất kết quả:** 
   * Sau khi hoàn tất độ trễ xử lý của các tầng pipeline, kết quả phổ tần số ngõ ra xuất hiện tại `dout_real` và `dout_imag`. Đồng thời, xung cờ `done` được bật lên `1` để báo hiệu quá trình biến đổi đã hoàn tất.

---

## 5. Kịch bản kiểm thử (Testbench Scenarios)

Hệ thống sử dụng các kịch bản testbench độc lập để kiểm chứng:
* **`tb_fft_16pt` & `tb_simple_fft`:** Kiểm tra tính đúng đắn của cấu trúc toán học cơ bản và các trường hợp dữ liệu mẫu tiêu chuẩn.
* **`tb_fft_mixed` (Testbench tích hợp tín hiệu hỗn hợp):** Bơm một chuỗi tín hiệu thời gian là sự chồng chập của nhiều thành phần tần số khác nhau. Testbench này giúp kiểm tra khả năng bóc tách chính xác các vạch phổ tần số của mạch phần cứng dưới dạng tín hiệu thực tế.

---

## 6. Hướng dẫn chạy mô phỏng trên ModelSim

Để mô phỏng và kiểm tra dạng sóng của hệ thống, bạn thực hiện các bước sau trên phần mềm ModelSim:

1. Mở phần mềm ModelSim và tạo một Project mới (ví dụ: `FFT_16pt_Project`).
2. Add toàn bộ các file mã nguồn Verilog (`fft_16pt.v`, `simple_fft.v`) và các file testbench (`tb_fft_mixed.v`, v.v.) vào project.
3. Tiến hành **Compile** (Biên dịch) toàn bộ mã nguồn để đảm bảo không có lỗi cú pháp.
4. Mở cửa sổ **Simulate** -> Chọn file testbench cần chạy (ví dụ: `tb_fft_mixed`).
5. Thêm các tín hiệu cần quan sát (`clk`, `rst_n`, `start`, `din_real`, `dout_real`, `dout_imag`, `done`) vào cửa sổ **Wave**.
6. Chạy lệnh `run -all` (hoặc chạy theo số chu kỳ clock nhất định) và quan sát dạng sóng ngõ ra để đối chiếu kết quả.

---

## 7. Kết quả thực nghiệm (Waveform Results)

*(Bạn có thể chụp hình ảnh cửa sổ Waveform kết quả chạy mô phỏng trên ModelSim và chèn vào đây)*
* **Xung nhịp & Điều khiển:** `clk` đập đều đặn, tín hiệu `start` kích hoạt thành công.
* **Ngõ ra:** Quan sát tín hiệu `done` bật lên `1`, đồng thời các cổng `dout_real` và `dout_imag` xuất hiện các giá trị biên độ tương ứng với các đỉnh phổ tần số sau khi biến đổi.
