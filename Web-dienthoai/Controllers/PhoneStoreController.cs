using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Dynamic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_dienthoai.Models;
using System.IO;

namespace Web_dienthoai.Controllers
{
    public class PhoneStoreController : Controller
    {
        QLDienThoaiEntities db = new QLDienThoaiEntities();

        // GET: PhoneStore
        public ActionResult Index()
        {
            var Pview = new List<ProductView>();
            var sanpham = db.SanPham.ToList();

            foreach (var item in sanpham)
            {
                var hinhSP = db.HinhSP.FirstOrDefault(id => id.MaSP == item.MaSP);
                var MyView = new ProductView()
                {
                    SanPham = item,
                    HinhSP = hinhSP,
                    ChiTietSP=db.ChiTietSP.FirstOrDefault(s=>s.MaSP==item.MaSP)
                };
                Pview.Add(MyView);
            }

            return View(Pview);
        }


        public ActionResult LayHangDT()
        {
            var dsDT = db.ThuongHieu.ToList();
            return PartialView(dsDT);
        }


        public ActionResult SPTheoHang(string MaTH)
        {
            var listsp = new List<ProductView>();
            var sanpham = db.SanPham.ToList();
            var brand = db.ThuongHieu.FirstOrDefault(id => id.MaTH == MaTH);

            foreach (var item in sanpham)
            {
                var hinhSP = db.HinhSP.FirstOrDefault(id => id.MaSP == item.MaSP);

                var myview = new ProductView()
                {
                    SanPham = item,
                    HinhSP = hinhSP,
                    ThuongHieu = brand,
                    ChiTietSP = db.ChiTietSP.FirstOrDefault(s => s.MaSP == item.MaSP)
                };

                listsp.Add(myview);
            }

            ViewBag.HangDT = brand.TenTH;

            var filter = listsp.Where(id => id.SanPham.MaTH == MaTH).ToList();

            return View(filter);
        }



        public ActionResult Details(string id)
        {
            var list = new List<DetailsView>();

            var phone = db.SanPham.FirstOrDefault(s => s.MaSP == id);
            var detail = db.ChiTietSP.FirstOrDefault(s => s.MaSP == id);
            var tskt = db.TSKTSP.FirstOrDefault(s => s.MaSP == id);

            var pics = (from h in db.HinhSP
                        join s in db.SanPham on h.MaSP equals s.MaSP
                        where s.MaSP == id
                        select h).ToList();
            var binhluan = db.BinhLuan.Where(s => s.MaSP == id).ToList();

            var myview = new DetailsView()
            {
                SanPham = phone,
                ChiTietSP = detail,
                TSKTSP = tskt,
                HinhSP = pics,
                BinhLuan = binhluan
            };
            if (binhluan.Count == 0) ViewBag.thongbao = "(Chưa có đánh giá)";

            list.Add(myview);
            Session["spdangxem"] = id;
            return View(myview);
        }

        [HttpGet]
        public ActionResult BinhLuanKH()
        {
            var masp = Session["spdangxem"].ToString();
            HinhSP hinhsp = db.HinhSP.FirstOrDefault(s => s.MaSP == masp);
            string hinh = hinhsp.MaHinh.ToString();
            var sanpham = db.SanPham.FirstOrDefault(s => s.MaSP == masp);
            ViewBag.hinhsp = hinh;
            ViewBag.tensp = sanpham.TenSP;
            ViewBag.masp = sanpham.MaSP;
            var kh = Session["KhachHang"] as KhachHang;
            if (kh != null) ViewBag.sty = "display:none";
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult BinhLuanKH([Bind(Include = "Chiase,HoTen,SDT")] BinhLuan bl, HttpPostedFileBase Anh)
        {
            if (ModelState.IsValid)
            {
                var khach = Session["KhachHang"] as KhachHang;
                if (string.IsNullOrEmpty(bl.Chiase))
                    ModelState.AddModelError(string.Empty, "Xin đóng góp ý kiến của bạn");
                if ((string.IsNullOrEmpty(bl.SDT) ||string.IsNullOrEmpty(bl.HoTen)) && khach==null)
                    ModelState.AddModelError(string.Empty, "Họ tên hoặc Số điện thoại không được để trống");
                if (khach != null)
                {

                    bl.MaKH = khach.MaKH;
                    bl.SDT = khach.SDT;
                    bl.HoTen = khach.TenKH;

                }

                if (Anh != null)
                {
                    //Lấy tên file của hình được up lên

                    var fileName = Path.GetFileName(Anh.FileName);

                    //Tạo đường dẫn tới file

                    var path = Path.Combine(Server.MapPath("~/Images/BinhLuan"), fileName);
                    //Lưu tên

                    bl.Anh = fileName;
                    //Save vào Images Folder
                    Anh.SaveAs(path);

                }
                if (ModelState.IsValid)
                {
                    bl.TrangThai = true;
                    bl.ThoiGian = DateTime.Now;
                    bl.MaSP = Session["spdangxem"].ToString();
                    db.BinhLuan.Add(bl);
                    db.SaveChanges();
                    return RedirectToAction("CamOn");
                }

            }
            var masp = Session["spdangxem"].ToString();
            HinhSP hinhsp = db.HinhSP.FirstOrDefault(s => s.MaSP == masp);
            string hinh = hinhsp.MaHinh.ToString();
            var sanpham = db.SanPham.FirstOrDefault(s => s.MaSP == masp);
            ViewBag.hinhsp = hinh;
            ViewBag.tensp = sanpham.TenSP;
            ViewBag.masp = sanpham.MaSP;
            var kh = Session["KhachHang"] as KhachHang;
            if (kh != null) ViewBag.sty = "display:none";
            return View();
        }
        public ActionResult CamOn()
        {
            var masp = Session["spdangxem"].ToString();
            ViewBag.masp = masp;
            return View();
        }
    }
}