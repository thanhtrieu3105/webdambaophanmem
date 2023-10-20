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
    public class QuanLyDonHangController : Controller
    {
        private QLDienThoaiEntities db = new QLDienThoaiEntities();

        // GET: QuanLyDonHang
        public ActionResult Index()
        {
            return View(db.DonHang.ToList());
        }

        // GET: QuanLyDonHang/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var list = new List<ChiTietDonHangView>();

            var donhang = db.DonHang.FirstOrDefault(s => s.MaDH == id);

            var chitietdonhang = db.ChiTietDH.Where(s => s.MaDH == donhang.MaDH);
            //List CTSPV
            var ListCTSP = new List<CTSPView>();
            int? slsp = 0;
            int phivanchuyen = 0;
            foreach (var item in chitietdonhang.ToList())
            {
                var MaCTSP = item.MaCTSP;
                var ctspv = new CTSPView(MaCTSP, item.SoLuong);
                ListCTSP.Add(ctspv);
                slsp += ctspv.SoLuong;
            }
            if (donhang.HTGiaohang == "Giao hàng tiêu chuẩn") phivanchuyen = 30000;
            else phivanchuyen = 66000;
            ViewBag.phivc = phivanchuyen;
            ViewBag.tongsl = slsp;
            var ChiTietDonHangView = new ChiTietDonHangView(ListCTSP, donhang);
            return View(ChiTietDonHangView);
        }

        // GET: QuanLyDonHang/Create
        //public ActionResult Create()
        //{
        //    return View();
        //}

        //// POST: QuanLyDonHang/Create
        //// To protect from overposting attacks, enable the specific properties you want to bind to, for 
        //// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //public ActionResult Create()
        //{
        //    if (ModelState.IsValid)
        //    {
        //        //db.DonHang.Add(donHang);
        //        db.SaveChanges();
        //        return RedirectToAction("Index");
        //    }

        //    return View();
        //}

        // GET: QuanLyDonHang/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DonHang donHang = db.DonHang.Find(id);
            if (donHang == null)
            {
                return HttpNotFound();
            }
            return View(donHang);
        }

        // POST: QuanLyDonHang/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "MaDH,MaKH,TenNguoiNhan,SDTnhan,DiaChiNhan,TriGia,TinhTrang,NgayDH,HTThanhToan,HTGiaohang,TongTien")] DonHang donHang)
        {
            if (ModelState.IsValid)
            {
                db.Entry(donHang).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(donHang);
        }

        // GET: QuanLyDonHang/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DonHang donHang = db.DonHang.Find(id);
            if (donHang == null)
            {
                return HttpNotFound();
            }
            return View(donHang);
        }

        // POST: QuanLyDonHang/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            DonHang donHang = db.DonHang.Find(id);
            db.DonHang.Remove(donHang);
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

        public ActionResult XacNhanDonHang(string id)
        {
            // Lấy thông tin đơn hàng từ cơ sở dữ liệu
            var donhang = db.DonHang.Find(id);
            if (donhang.TinhTrang == "Đã hủy")
            {
                return Content("Đơn hàng đã hủy không được xác nhận");
            }

            // Cập nhật trạng thái đơn hàng thành Đã xác nhận
            else
            {
                donhang.TinhTrang = "Đã xác nhận";
                db.SaveChanges();
            }
            // Chuyển hướng đến trang chi tiết đơn hàng
            return RedirectToAction("Index");
        }

        public ActionResult HuyDonHang(string id)
        {
            // Lấy thông tin đơn hàng từ cơ sở dữ liệu
            var donhang = db.DonHang.Find(id);
            if (donhang.TinhTrang == "Đã xác nhận")
            {
                return Content("Đơn hàng đã xác nhận không được hủy");
            }

            // Cập nhật trạng thái đơn hàng thành Đã hủy
            else
            {
                donhang.TinhTrang = "Đã hủy";
                db.SaveChanges();
            }
            // Chuyển hướng đến trang chi tiết đơn hàng
            return RedirectToAction("Index");
        }
    }
}
