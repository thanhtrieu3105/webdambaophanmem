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
    public class QuanLyTSKTSPController : Controller
    {
         QLDienThoaiEntities db = new QLDienThoaiEntities();

        // GET: QuanLyTSKTSP
        public ActionResult Index(string id)
        {
            var tSKTSPs = db.TSKTSP.Where(t => t.MaSP == id);
            return View(tSKTSPs.ToList());
        }

        // GET: QuanLyTSKTSP/Details/5
        public ActionResult Details(string id)
        {
            if (id == null) return RedirectToAction("Index", "QuanLySanPham", null);
            var ts = db.TSKTSP.FirstOrDefault(s=>s.MaSP==id);
            return View(ts);
        }

        // GET: QuanLyTSKTSP/Create
        public ActionResult Create()
        {
            ViewBag.MaSP = new SelectList(db.SanPham, "MaSP", "TenSP");
            return View();
        }

        // POST: QuanLyTSKTSP/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat")] TSKTSP tSKTSP)
        {
            if (ModelState.IsValid)
            {
                db.TSKTSP.Add(tSKTSP);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.MaSP = new SelectList(db.SanPham, "MaSP", "TenSP", tSKTSP.MaSP);
            return View(tSKTSP);
        }

        // GET: QuanLyTSKTSP/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TSKTSP tSKTSP = db.TSKTSP.Find(id);
            if (tSKTSP == null)
            {
                return HttpNotFound();
            }
            ViewBag.MaSP = new SelectList(db.SanPham, "MaSP", "TenSP", tSKTSP.MaSP);
            return View(tSKTSP);
        }

        // POST: QuanLyTSKTSP/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat")] TSKTSP tSKTSP)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tSKTSP).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.MaSP = new SelectList(db.SanPham, "MaSP", "TenSP", tSKTSP.MaSP);
            return View(tSKTSP);
        }

        // GET: QuanLyTSKTSP/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TSKTSP tSKTSP = db.TSKTSP.Find(id);
            if (tSKTSP == null)
            {
                return HttpNotFound();
            }
            return View(tSKTSP);
        }

        // POST: QuanLyTSKTSP/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            TSKTSP tSKTSP = db.TSKTSP.Find(id);
            db.TSKTSP.Remove(tSKTSP);
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
