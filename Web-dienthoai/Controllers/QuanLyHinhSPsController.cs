using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Web_dienthoai.Models;

namespace Web_dienthoai.Controllers
{
    public class QuanLyHinhSPsController : Controller
    {
        private QLDienThoaiEntities db = new QLDienThoaiEntities();

        // GET: QuanLyHinhSPs
        public ActionResult Index(string id)
        {
            var hinhSPs = db.HinhSP.Where(h => h.MaSP == id);
            return View(hinhSPs.ToList());
        }

        // GET: QuanLyHinhSPs/Details/5

        // GET: QuanLyHinhSPs/Create
        public ActionResult Create(String id)
        {
            ViewBag.MaSP = id;
            return View();
        }

        // POST: QuanLyHinhSPs/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "HinhSP,MaSP")] HinhSP hinhSP, HttpPostedFileBase Anh)
        {
            string id = hinhSP.MaSP;
            if (Anh == null || Anh.FileName == null)
            {
                ModelState.AddModelError(string.Empty, "Ảnh sản phẩm không được để trống");
            }
            else
            {
                var fileName1 = Path.GetFileName(Anh.FileName);
                if (db.HinhSP.Any(s => s.MaHinh == fileName1))
                {
                    ModelState.AddModelError(string.Empty, "Trùng tên hình với sản phẩm khác");
                }
            }

            if (ModelState.IsValid)
            {
                var hinhsp = new HinhSP();
                if (Anh != null && Anh.FileName != null)
                {
                    var fileName = Path.GetFileName(Anh.FileName);
                    var path = Path.Combine(Server.MapPath("~/Images/Phones"), fileName);
                    hinhsp.MaHinh = fileName;
                    hinhsp.MaSP = hinhSP.MaSP;
                    Anh.SaveAs(path);
                }

                db.HinhSP.Add(hinhsp);
                db.SaveChanges();
               
                return RedirectToAction("Index", "QuanLyHinhSPs",new { id=id});
            }

            ViewBag.MaSP = id;
            return View(id);
        }

        // GET: QuanLyHinhSPs/Edit/5
        //public ActionResult Edit(string id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    HinhSP hinhSP = db.HinhSP.Find(id);
        //    if (hinhSP == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    ViewBag.MaSP = new SelectList(db.SanPham, "MaSP", "TenSP", hinhSP.MaSP);
        //    return View(hinhSP);
        //}

        //// POST: QuanLyHinhSPs/Edit/5
        //// To protect from overposting attacks, enable the specific properties you want to bind to, for 
        //// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult Edit([Bind(Include = "MaHinh,MaSP")] HinhSP hinhSP)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        db.Entry(hinhSP).State = EntityState.Modified;
        //        db.SaveChanges();
        //        return RedirectToAction("Index");
        //    }
        //    ViewBag.MaSP = new SelectList(db.SanPham, "MaSP", "TenSP", hinhSP.MaSP);
        //    return View(hinhSP);
        //}

        // GET: QuanLyHinhSPs/Delete/5
        public ActionResult Delete(string id, string masp)
        {
           
                HinhSP hinhSP = db.HinhSP.FirstOrDefault(s=>s.MaHinh== id);
            db.HinhSP.Remove(hinhSP);
            return RedirectToAction("Index", "QuanLyHinhSPs", new { id=masp});

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
