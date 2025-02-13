using FinanceFlow.Server.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FinanceFlow.Server.Controllers
{
    public class ExpenseCategoryController : Controller
    {
        // GET: ExpenseCategoryController
        public ActionResult Index()
        {

            return View();
        }

        // GET: ExpenseCategoryController/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: ExpenseCategoryController/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: ExpenseCategoryController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: ExpenseCategoryController/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: ExpenseCategoryController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: ExpenseCategoryController/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: ExpenseCategoryController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }
    }
}
