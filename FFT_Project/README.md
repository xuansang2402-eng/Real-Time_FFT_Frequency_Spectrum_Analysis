# Real-Time FFT Frequency Spectrum Analysis (Verilog)

Hệ thống xử lý phổ tần số thời gian thực sử dụng thuật toán Fast Fourier Transform (FFT) viết bằng ngôn ngữ Verilog HDL, thiết kế tối ưu cho các ứng dụng phần cứng FPGA.

---

## 1. Sơ đồ khối tổng quát

*(Bạn có thể chụp ảnh sơ đồ khối mô phỏng/sơ đồ thiết kế của bạn rồi kéo thả vào đây, hoặc dùng cú pháp sơ đồ dưới đây)*

```text
[ Input Data (Real/Imag) ] ---> [ fft_16pt / simple_fft ] ---> [ Xử lý phổ & Hiển thị ]
