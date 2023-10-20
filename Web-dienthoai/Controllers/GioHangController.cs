using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_dienthoai.Models;

namespace Web_dienthoai.Controllers
{
    public class GioHangController : Controller
    {
        QLDienThoaiEntities db = new QLDienThoaiEntities();
        // GET: GioHang
        public List<MatHangMua> LayGioHang()
        {
            List<MatHangMua> gioHang = Session["GioHang"] as List<MatHangMua>;

            if (gioHang == null)
            {
                gioHang = new List<MatHangMua>();
                Session["GioHang"] = gioHang;
            }
            return gioHang;
        }

        public ActionResult ThemSP(string MaSP)
        {
            List<MatHangMua> gioHang = LayGioHang();


            MatHangMua phone = gioHang.FirstOrDefault(s => s.MaSP == MaSP);
            if (phone == null)
            {
                phone = new MatHangMua(MaSP);
                gioHang.Add(phone);
            }
            else
            {
                phone.SoLuong++;
            }
            return RedirectToAction("Details", "PhoneStore", new { id = MaSP });
        }


        private int TinhTongSL()
        {
            int tongSL = 0;
            List<MatHangMua> gioHang = LayGioHang();
            if (gioHang != null)
            {
                tongSL = gioHang.Sum(id => id.SoLuong);
            }
            return tongSL;
        }

        private double TinhTongTien()
        {
            double TongTien = 0;
            List<MatHangMua> gioHang = LayGioHang();
            if (gioHang != null)
            {
                TongTien = gioHang.Sum(sp => sp.ThanhTien());
            }
            return TongTien;
        }


        public ActionResult HienThiGioHang()
        {
            List<MatHangMua> gioHang = LayGioHang();

            if (gioHang == null || gioHang.Count == 0)
            {
                return RedirectToAction("Index", "PhoneStore");
            }
            ViewBag.TongSL = TinhTongSL();
            ViewBag.TongTien = TinhTongTien();
            return View(gioHang);
        }


        public ActionResult GioHangPartial()
        {
            ViewBag.TongSL = TinhTongSL();
            return PartialView();
        }


        public ActionResult XoaMatHang(string MaSP)
        {
            List<MatHangMua> gioHang = LayGioHang();

            //Lấy sp trong giỏ
            var sanpham = gioHang.FirstOrDefault(id => id.MaSP == MaSP);
            if (sanpham != null)
            {
                gioHang.RemoveAll(id => id.MaSP == MaSP);
                return RedirectToAction("HienThiGioHang"); //Route về trang giỏ hàng
            }
            if (gioHang.Count == 0)
            {
                return RedirectToAction("Index", "PhoneStore"); //Route về trang chủ nếu không có gì
            }
            return RedirectToAction("HienThiGioHang");
        }


        public ActionResult CapNhatMatHang(string MaSP, int Soluong)
        {
            //Lấy giỏ hàng
            List<MatHangMua> gioHang = LayGioHang();

            //Lấy SP trong giỏ hàng
            var sanpham = gioHang.FirstOrDefault(id => id.MaSP == MaSP);
            if (sanpham != null)
            {
                //Cập nhật số lượng tương ứng
                //Số lượng luôn >= 1
                sanpham.SoLuong = Soluong;
            }
            return RedirectToAction("HienThiGioHang");
        }
        [HttpGet]
        public ActionResult ThongTinMuaHang()
        {
            List<MatHangMua> giohang = LayGioHang();
            if (giohang == null || giohang.Count == 0) return RedirectToAction("Index", "PhoneStore");
            ViewBag.TongSL = TinhTongSL();
            ViewBag.TongTien = TinhTongTien();
            ViewBag.TongCong = TinhTongTien();
            return View(giohang);
        }
        [HttpPost]
        public ActionResult ThongTinMuaHang(DonHang dh)
        {
            if (ModelState.IsValid)
            {
                if (String.IsNullOrEmpty(dh.TenNguoiNhan))
                    ModelState.AddModelError(String.Empty, "Họ tên không được để trống ");
                if (String.IsNullOrEmpty(dh.SDTnhan))
                    ModelState.AddModelError(String.Empty, "SDT không được để trống ");
                if (String.IsNullOrEmpty(dh.DiaChiNhan))
                    ModelState.AddModelError(String.Empty, "Địa chỉ không được để trống ");
                if (String.IsNullOrEmpty(dh.HTThanhToan))
                    ModelState.AddModelError(String.Empty, " Hình Thức Thanh Toán không được để trống ");
                if (String.IsNullOrEmpty(dh.HTGiaohang))
                    ModelState.AddModelError(String.Empty, " Hình Thức Giao Hàng không được để trống ");
                if (ModelState.IsValid)
                {
                    dh.MaDH = TaoMa("mdh");//tạo tự động mã mới không trùng trong database
                    dh.TriGia = ((int)TinhTongTien());
                    dh.TongTien = ((int)TinhTongTien());
                    dh.TinhTrang = "Chờ Duyệt";
                    dh.NgayDH = DateTime.Now;
                }
                else
                    return View();
            }
            if (dh.HTGiaohang == "Giao hàng tiêu chuẩn") dh.TongTien += 30000;
            else dh.TongTien += 66000;
//AP DUNG PROC LUU DON HANG
            db.ThemDH(dh.MaDH,dh.MaKH,dh.TenNguoiNhan,dh.SDTnhan,dh.DiaChiNhan,dh.TriGia,dh.HTThanhToan,dh.HTGiaohang,dh.TongTien);
          //   db.DonHang.Add(dh);//luu don hang vao database
            db.SaveChanges(); //luu truoc khi tạo chi tiết don hàng để có mã đơn hàng trong database

            DonHang dh1 = LayTTDon(); //lay thong tin don trong sesion neu co
            dh1 = dh;//gan  don hang moi dien 
            Session["TTdonHang"] = dh1; //luu vao sesion khi tao tk moi cho kh co madh tim databse


            //them chi tiet don hang vao database
            //ChiTietDH ctdh;
            List<MatHangMua> giohang = LayGioHang();
            foreach (var item in giohang)
            {
                //ctdh = new ChiTietDH();
                //ctdh.MaCTDH = TaoMa("ctdh");//tạo tự động mã mới không trùng trong database
                //ctdh.SoLuong = item.SoLuong;
                //ctdh.Thanhtien = ((int)item.ThanhTien());
                //ctdh.MaCTSP = item.MaCTSP;
                //ctdh.MaDH = dh.MaDH;
                //ctdh.GiaMua = ((int)item.DonGia);
                //db.ChiTietDH.Add(ctdh);
//AP DUNG PROC LUU CHI TIET DON HANG
                db.ThemCTDH(TaoMa("ctdh"), item.SoLuong, ((int)item.DonGia), item.MaCTSP, dh.MaDH, ((int)item.ThanhTien()));
                db.SaveChanges();
            }
           

          //ktr dang nhap neu co dang nhap thi luu don hàng cho tai khoan do
            var kh = Session["KhachHang"] as KhachHang;

            if (kh != null)
            {//dang dang nhap
                DonHang x = db.DonHang.FirstOrDefault(s => s.MaDH == dh.MaDH);
                x.MaKH = kh.MaKH;// gan mã khách vào đơn hàng moi tao
                db.SaveChanges();
                return RedirectToAction("DatHangThanhCong");
            }
            else
            {
                
                return RedirectToAction("CauHoiDKTK"); //tao khach hang moi bang thong tin giao hang
            }

          
        }
        public string TaoMa(string bien)
        {
            int ma = 1000;
            if (bien == "mdh")
            {

                string madh = ma.ToString();
                //kiem tra ton tai ma don hang
                while (db.DonHang.FirstOrDefault(s => s.MaDH == madh) != null)
                {
                    ma++;
                    madh =  ma.ToString();
                }
                return madh;
            }
            if (bien == "mkh")
            {

                string makh =  ma.ToString();
                //kiem tra ton tai ma don hang
                while (db.KhachHang.FirstOrDefault(s => s.MaKH == makh) != null)
                {
                    ma++;
                    makh =  ma.ToString();
                }
                return makh;
            }
            if (bien == "ctdh")
            {
                ma = 100000;
                string madh =  ma.ToString();
                //kiem tra ton tai ma don hang
                while (db.ChiTietDH.FirstOrDefault(s => s.MaCTDH == madh) != null)
                {
                    ma++;
                    madh =  ma.ToString();
                   
                }
                return madh;
            }
            else return null;

        }
        public ActionResult CauHoiDKTK()
        {

            if (Session["TaiKhoan"] == null)// chua dang nhap
            {
                return View();
            }
            return RedirectToAction("DatHangThanhCong");
        }
        public ActionResult DatHangThanhCong()
        {
            Session["GioHang"] = null;
            Session["TTDonHang"] = null;
            return View();
        }
        public DonHang LayTTDon()
        {
            DonHang dh = Session["TTDonHang"] as DonHang;
            //neu gio hang chua ton tai thi  tao moi dua vao session
            if (dh == null)
            {
                dh = new DonHang();
                Session["TTDonHang"] = dh;
            }
            return dh;
        }
        public ActionResult ThongTinDKTK()
        {

            var dh = LayTTDon(); //lay ma don hang vua dien buoc truoc gan vao tai khoan moi tao
            if (dh == null) return RedirectToAction("HienThiGioHang");//test loi code k lien quan
            if (db.KhachHang.FirstOrDefault(s => s.SDT == dh.SDTnhan) != null)//lay sdt lm tk kiem tra co trung tk khong 
            {
                ViewBag.thongbao = "SDT đã được dùng không thể tạo tài khoản mới.";
                return View();
            }
            else
            {
                 Random rd = new Random();
                string mk = rd.Next(12547653,95678456).ToString();
                //var tk = new KhachHang();
                //tk.MaKH = TaoMa("mkh");
                //tk.TenKH = dh.TenNguoiNhan;
                //tk.SDT = dh.SDTnhan;
                //tk.DiaChi = dh.DiaChiNhan;
                //tk.MK = mk;
                //tk.MaLoaiKH = "LKH01";
                //db.KhachHang.Add(tk);
//ap dung PROC TAO TAI KHOAN
          
                db.ThemKH(TaoMa("mkh"), dh.TenNguoiNhan, dh.SDTnhan, dh.DiaChiNhan,"Nam",DateTime.Now, mk, "");
                db.SaveChanges();
           
                ViewBag.TenDN = dh.SDTnhan;
                ViewBag.MK = mk;
                ViewBag.TENKH = dh.TenNguoiNhan;
                ViewBag.DIACHI = dh.DiaChiNhan;
                ViewBag.thongbao = "Đơn hàng đã được lưu vào tài khoản";
                //gan ma khachhang vao don hang vua mua
                var a = db.KhachHang.FirstOrDefault(s => s.SDT == dh.SDTnhan);
                var donhang = db.DonHang.FirstOrDefault(s => s.MaDH == dh.MaDH);
                donhang.MaKH = a.MaKH;
                db.SaveChanges();
                Session["GioHang"] = null;
                Session["TTDonHang"] = null;
                return View();
            }

        }

    }
}