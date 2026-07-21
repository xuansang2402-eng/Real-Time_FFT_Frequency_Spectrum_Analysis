# Real-Time FFT Frequency Spectrum Analysis (Verilog)

Hệ thống xử lý phổ tần số thời gian thực sử dụng thuật toán Fast Fourier Transform (FFT) viết bằng ngôn ngữ Verilog HDL, thiết kế tối ưu cho các ứng dụng phần cứng FPGA.

---

## 1. Sơ đồ khối tổng quát

*(Bạn có thể chụp ảnh sơ đồ khối mô phỏng/sơ đồ thiết kế của bạn rồi kéo thả vào đây, hoặc dùng cú pháp sơ đồ dưới đây)*

```text
[ Input Data (Real/Imag) ] ---> [ fft_16pt / simple_fft ] ---> [ Xử lý phổ & Hiển thị ]

## 2. Mục lục các module (Module Index)

| # | Module | File | Vai trò |
|---|--------|------|---------|
| 1 | `fft_16pt` | `fft_16pt.v` | Module chính thực hiện thuật toán FFT 16 điểm |
| 2 | `simple_fft` | `simple_fft.v` | Phiên bản FFT cơ bản dùng để đối chiếu, thử nghiệm |
| 3 | `tb_fft_16pt` | `tb_fft_16pt.v` | Testbench mô phỏng kiểm tra module `fft_16pt` |
| 4 | `tb_simple_fft` | `tb_simple_fft.v` | Testbench kiểm tra module `simple_fft` |
| 5 | `tb_fft_mixed` | `tb_fft_mixed.v` | Testbench kiểm tra tích hợp hệ thống và các trường hợp hỗn hợp |
