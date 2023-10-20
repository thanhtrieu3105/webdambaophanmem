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
    public class PhieuGiamGiasController : Controller
    {
        private QLDienThoaiEntities db = new QLDienThoaiEntities();

        // GET: PhieuGiamGias
        public ActionResult Index()
        {
            return View(db.PhieuGiamGia.ToList());
        }
        public ActionResult dsSPApDung(int? id)
        {
            Session["idgiamgia"] = id;
            var dssp = (from s in db.SanPham join g in db.GiamGiaSP on s.MaSP equals g.MaSP
                        where g.MaGG == id select s).ToList();
            ViewBag.tenmgg = db.PhieuGiamGia.FirstOrDefault(s => s.MaGG == id).TenGiamGia;
            ViewBag.id = id;
            return View(dssp);
        }
        public ActionResult dsSPChuaApDung(int? id)
        {
            Session["idgiamgia"] = id;
            var dssp = from sanPham in db.SanPham
                         where !db.GiamGiaSP.Select(sp => sp.MaSP).Contains(sanPham.MaSP)
                         select sanPham;
            ViewBag.tenmgg = db.PhieuGiamGia.FirstOrDefault(s => s.MaGG == id).TenGiamGia;
            ViewBag.id = id;
            return View(dssp.ToList());
        }
        public ActionResult ApDung(string MaSP,int id)
        {
                var sanphamgg = new GiamGiaSP();
                sanphamgg.MaSP = MaSP;
                sanphamgg.MaGG = id;
                db.GiamGiaSP.Add(sanphamgg);
                db.SaveChanges();
            return RedirectToAction("dsSPChuaApDung", new { id = id });
        }
        public ActionResult Huy(string MaSP, int id)
        {
            var sanphamgg = db.GiamGiaSP.FirstOrDefault(s => s.MaSP == MaSP && s.MaGG == id);
            db.GiamGiaSP.Remove(sanphamgg);
            db.SaveChanges();
            return RedirectToAction("dsSPApDung",new { id=id} );
        }
        // GET: PhieuGiamGias/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            PhieuGiamGia phieuGiamGia = db.PhieuGiamGia.Find(id);
            if (phieuGiamGia == null)
            {
                return HttpNotFound();
            }
            return View(phieuGiamGia);
        }

        // GET: PhieuGiamGias/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: PhieuGiamGias/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "MaGG,TenGiamGia,chietkhau")] PhieuGiamGia phieuGiamGia)
        {
            if (ModelState.IsValid)
            {
                phieuGiamGia.chietkhau = phieuGiamGia.chietkhau / 100;
                db.PhieuGiamGia.Add(phieuGiamGia);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(phieuGiamGia);
        }

        // GET: PhieuGiamGias/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            PhieuGiamGia phieuGiamGia = db.PhieuGiamGia.Find(id);
            if (phieuGiamGia == null)
            {
                return HttpNotFound();
            }
            return View(phieuGiamGia);
        }

        // POST: PhieuGiamGias/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "MaGG,TenGiamGia,chietkhau")] PhieuGiamGia phieuGiamGia)
        {
            if (ModelState.IsValid)
            {
                phieuGiamGia.chietkhau = phieuGiamGia.chietkhau / 100;
                db.Entry(phieuGiamGia).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(phieuGiamGia);
        }

        // GET: PhieuGiamGias/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            PhieuGiamGia phieuGiamGia = db.PhieuGiamGia.Find(id);
            var ktr = db.GiamGiaSP.FirstOrDefault(s => s.MaGG == id) ?.MaGGSP;
            if (ktr != null) ViewBag.tb = "Đang có sản phẩm áp dụng phiếu giảm giá này tiếp tục xóa?";
            if (phieuGiamGia == null)
            {
                return HttpNotFound();
            }
            return View(phieuGiamGia);
        }

        // POST: PhieuGiamGias/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            PhieuGiamGia phieuGiamGia = db.PhieuGiamGia.Find(id);
            db.XoaPhieuGG(id);
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
    }
}
