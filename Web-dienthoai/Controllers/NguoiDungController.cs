using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_dienthoai.Models;

namespace Web_dienthoai.Controllers
{
    public class NguoiDungController : Controller
    {
         QLDienThoaiEntities db = new QLDienThoaiEntities();
        public string TaoMa(string bien)
        {
            int ma = 10;
            if (bien == "kh")
            {

                string makh = "KH" + ma.ToString();
                //kiem tra ton tai ma don hang
                while (db.KhachHang.FirstOrDefault(s => s.MaKH == makh) != null)
                {
                    ma++;
                    makh = "KH" + ma.ToString();
                }
                return makh;
            }
          
            else return null;

        }

        // GET: NguoiDung
        [HttpGet]
        public ActionResult DangKy()
        {
            return View();
        }


        [HttpPost]
        public ActionResult DangKy(KhachHang kh)
        {
            if(ModelState.IsValid)
            {
                if (string.IsNullOrEmpty(kh.TenKH))
                    ModelState.AddModelError(string.Empty, "Họ tên không được để trống");
                if (string.IsNullOrEmpty(kh.MK))
                    ModelState.AddModelError(string.Empty, "Mật khẩu không được để trống");
                if (string.IsNullOrEmpty(kh.Email))
                    ModelState.AddModelError(string.Empty, "Email không được để trống");
                if (string.IsNullOrEmpty(kh.DiaChi))
                    ModelState.AddModelError(string.Empty, "Dịa chỉ không được để trống");
                if (string.IsNullOrEmpty(kh.SDT))
                    ModelState.AddModelError(string.Empty, "Điện thoại không được để trống");

                //Kiểm tra đã có ai đk tài khoản này hay chưa
                var khachhang = db.KhachHang.FirstOrDefault(id => id.SDT == kh.SDT);
                if(khachhang != null)
                    ModelState.AddModelError(string.Empty, "SDT đã được sử dụng, hãy chọn SDT khác");

                if (ModelState.IsValid)
                {
                    try
                    {
                        kh.MaKH = TaoMa("kh");
                        db.KhachHang.Add(kh);
                        db.SaveChanges();
                    }
                    catch
                    {
                        return Content("LỖI TẠO MỚI TÀI KHOẢN!");
                    }
                }
                else
                {
                    return View();
                }
            }
            return RedirectToAction("DangNhap");
        }


        [HttpGet]
        public ActionResult DangNhap()
        {
            return View();
        }


        [HttpPost]
        public ActionResult DangNhap(KhachHang kh)
        {
         
                if (string.IsNullOrEmpty(kh.SDT))
                    ModelState.AddModelError(string.Empty, "Vui lòng điền tên đăng nhập");
                if (string.IsNullOrEmpty(kh.MK))
                    ModelState.AddModelError(string.Empty, "Vui lòng điền mật khẩu");

                if (ModelState.IsValid)
                {
                    //Tìm KH hợp lệ có trong CSDL
                    var khachhang = db.KhachHang.FirstOrDefault(id => id.SDT == kh.SDT && id.MK == kh.MK);
                    if (khachhang != null)
                    {
                        ViewBag.ThongBao = "Đăng nhập thành công!";
                        //Lưu > session
                        Session["KhachHang"] = khachhang;
                        return RedirectToAction("Index", "PhoneStore");
                    }
                    else
                        ViewBag.ThongBao = "Tên đăng nhập hoặc mật khẩu không hợp lệ !";
                }
            
            return View();
        }
        public ActionResult UserPartial()

        {
            var kh = Session["KhachHang"] as KhachHang;
            if (kh != null) ViewBag.name = kh.TenKH.ToString();
            else ViewBag.name = "";


            return PartialView();
        }

       
        public ActionResult DangXuat()
        {
            Session["KhachHang"] = null;
            Session["GioHang"] = null;

            return RedirectToAction("Index", "PhoneStore");
        }
       
        public ActionResult TrangTK() /*trang taikhoan khi link vao taikhoan*/
        {
            var kh = Session["KhachHang"] as KhachHang;
            if (kh == null)
            {
                return RedirectToAction("DangNhap");
            }
            return View(kh);
        }
        public ActionResult TrangThongTinTK() /*trang thong tin ca nhan */


        {
            var kh = Session["KhachHang"] as KhachHang;
            if(kh==null)
            {
                return RedirectToAction("DangNhap");
            }
            return View(kh);
        }
        public ActionResult LichSuMuaHang()
        {
            var kh = Session["KhachHang"] as KhachHang;
          
            var listdh = db.DonHang.Where(s => s.MaKH == kh.MaKH).ToList();
            List<ItemDonHang> listItemDH = new List<ItemDonHang>();
            ItemDonHang it;
            foreach (var item in listdh)
            {
                var mactdh = db.ChiTietDH.FirstOrDefault(s => s.MaDH == item.MaDH).MaCTDH;
                 it = new ItemDonHang(item.MaDH,mactdh);
                listItemDH.Add(it);
            }

            return View(listItemDH);
        }
        public ActionResult ChiTietDonHang(string id)
        {
            var list = new List<ChiTietDonHangView>();

            var donhang = db.DonHang.FirstOrDefault(s => s.MaDH == id);

            var chitietdonhang = db.ChiTietDH.Where(s => s.MaDH == donhang.MaDH);
            //List CTSPV
            var ListCTSP = new List<CTSPView>();
            int? slsp=0;
            int phivanchuyen = 0;
            foreach (var item in chitietdonhang.ToList())
            {
                var MaCTSP = item.MaCTSP;
                var ctspv = new CTSPView(MaCTSP,item.SoLuong);
                ListCTSP.Add(ctspv);
                slsp += ctspv.SoLuong;
            }
            if (donhang.HTGiaohang == "Giao hàng tiêu chuẩn")  phivanchuyen = 30000;
            else  phivanchuyen = 66000;
            ViewBag.phivc = phivanchuyen;
            ViewBag.tongsl = slsp;
            var ChiTietDonHangView = new ChiTietDonHangView(ListCTSP, donhang);
            return View(ChiTietDonHangView);
        }
        public ActionResult HuyDon(string id)
        {
            DonHang dh = db.DonHang.FirstOrDefault(s => s.MaDH == id);
            if(dh.TinhTrang=="Chờ Duyệt")
            {
                dh.TinhTrang = "Hủy";
                db.SaveChanges();
                ViewBag.thongbao = "Hủy đơn hàng thành công";
                return RedirectToAction("LichSuMuaHang");
            }
            ViewBag.thongbao = "Quý khách vui lòng từ chối khi nhận hàng";
            return RedirectToAction("LichSuMuaHang");
        }
        public ActionResult XacNhanHuyDon(string madh)
        {
            var kh = Session["KhachHang"] as KhachHang;
            ViewBag.makh = kh.MaKH;
            ViewBag.madh = madh;
            return View();
        }


    }
}




