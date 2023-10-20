using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Web_dienthoai.Models;

namespace Web_dienthoai.Controllers
{
    public class QuanLyKhachHangController : Controller
    {
        private QLDienThoaiEntities db = new QLDienThoaiEntities();

        // GET: QuanLyKhachHang
        public ActionResult Index()
        {
            var khachHangs = db.KhachHang.Include(k => k.LoaiKH);
            return View(khachHangs.ToList());
        }

        // GET: QuanLyKhachHang/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            KhachHang khachHang = db.KhachHang.Find(id);
            if (khachHang == null)
            {
                return HttpNotFound();
            }
            return View(khachHang);
        }

        // GET: QuanLyKhachHang/Create
        public ActionResult Create()
        {
            ViewBag.MaLoaiKH = new SelectList(db.LoaiKH, "MaLoaiKH", "TenLoaiKH");
            return View();
        }

        // POST: QuanLyKhachHang/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "TenKH,SDT,DiaChi,GioiTinh,NgaySinh,MK,Email,MaLoaiKH")] KhachHang khachHang)
        {
            if (ModelState.IsValid)
            {
                if (string.IsNullOrEmpty(khachHang.TenKH))
                    ModelState.AddModelError(string.Empty, "Họ tên không được để trống");
                if (string.IsNullOrEmpty(khachHang.MK))
                    ModelState.AddModelError(string.Empty, "Mật khẩu không được để trống");
                if (string.IsNullOrEmpty(khachHang.Email))
                    ModelState.AddModelError(string.Empty, "Email không được để trống");
                if (string.IsNullOrEmpty(khachHang.DiaChi))
                    ModelState.AddModelError(string.Empty, "Dịa chỉ không được để trống");
                if (string.IsNullOrEmpty(khachHang.SDT))
                    ModelState.AddModelError(string.Empty, "Điện thoại không được để trống");
                var sdtkh =db.KhachHang.FirstOrDefault(s => s.SDT == khachHang.SDT)?.SDT;
                if (sdtkh!=null)
                    ModelState.AddModelError(string.Empty, "Trung sdt");

                if (ModelState.IsValid)
                {
                    khachHang.MaKH = TaoMa();
                    db.KhachHang.Add(khachHang);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }


            ViewBag.MaLoaiKH = new SelectList(db.LoaiKH, "MaLoaiKH", "TenLoaiKH", khachHang.MaLoaiKH);
            return View(khachHang);
        }

        // GET: QuanLyKhachHang/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            KhachHang khachHang = db.KhachHang.Find(id);
            if (khachHang == null)
            {
                return HttpNotFound();
            }
            ViewBag.MaLoaiKH = new SelectList(db.LoaiKH, "MaLoaiKH", "TenLoaiKH", khachHang.MaLoaiKH);
            return View(khachHang);
        }

        // POST: QuanLyKhachHang/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "MaKH,TenKH,SDT,DiaChi,GioiTinh,NgaySinh,MK,Email,MaLoaiKH")] KhachHang khachHang)
        {
            if (ModelState.IsValid)
            {
                var kh = db.KhachHang.FirstOrDefault(s => s.SDT == khachHang.SDT);

                if (ModelState.IsValid)
                {
                    kh.TenKH = khachHang.TenKH;
                    kh.DiaChi = khachHang.DiaChi;
                    kh.GioiTinh = khachHang.GioiTinh;
                    kh.NgaySinh = khachHang.NgaySinh;
                    kh.MK = khachHang.MK;
                    kh.Email = khachHang.Email;
                    kh.MaLoaiKH = khachHang.MaLoaiKH;
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }

            ViewBag.MaLoaiKH = new SelectList(db.LoaiKH, "MaLoaiKH", "TenLoaiKH", khachHang.MaLoaiKH);
            return View(khachHang);
        }

        // GET: QuanLyKhachHang/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            KhachHang khachHang = db.KhachHang.Find(id);
            var khdh = db.DonHang.FirstOrDefault(s => s.MaKH == khachHang.MaKH)?.MaDH;
            var khbl = db.BinhLuan.FirstOrDefault(s => s.MaKH == khachHang.MaKH)?.MaBL;
            if (khachHang == null)
            {
                return HttpNotFound();
            }
            if (khdh != null || khbl != null) ViewBag.thongbao = "Khách hàng có đơn hàng hoặc bình luận trên hệ thống tiếp tục xóa?";
            return View(khachHang);
        }

        // POST: QuanLyKhachHang/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            var sdt  = db.KhachHang.FirstOrDefault(s=>s.MaKH==id).SDT;
            db.XoaKH(sdt);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
        public string TaoMa()
        {
            int ma = 1000;

            string makh = ma.ToString();
            //kiem tra ton tai ma don hang
            while (db.KhachHang.FirstOrDefault(s => s.MaKH == makh) != null)
            {
                ma++;
                makh = ma.ToString();
            }
            return makh;
        }

    }
}
