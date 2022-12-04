using System.Diagnostics;
using Newtonsoft.Json;
using Microsoft.AspNetCore.Mvc;
using WebAppStockAnalyzerHttpClient.Models;

namespace WebAppStockAnalyzerHttpClient.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;
    private static string API_URL = "https://ps-async.fekberg.com/api/stocks";

    public HomeController(ILogger<HomeController> logger)
    {
        _logger = logger;
    }

    public async Task<IActionResult> Index()
    {
        // return View();

        using (var client = new HttpClient())
        {
            var responseTask = client.GetAsync($"{API_URL}/MSFT");

            var response = await responseTask;

            var content = await response.Content.ReadAsStringAsync();

            var data = JsonConvert.DeserializeObject<IEnumerable<StockPrice>>(content);

            return View(data);
        }

    }

    public IActionResult Privacy()
    {
        return View();
    }

    public IActionResult JqueryTests()
    {
        return View();
    }

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}
