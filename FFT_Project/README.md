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
