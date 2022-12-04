namespace WebAppStockAnalyzerHttpClient.Models
{
    public class StockPrice
    {
        public string Identifier { get; set; } = default!;
        public DateTime TradeDate { get; set; } = default!;
        public decimal? Open { get; set; } = default!;
        public decimal? High { get; set; } = default!;
        public decimal? Low { get; set; } = default!;
        public decimal? Close { get; set; } = default!;
        public int Volume { get; set; } = default!;
        public decimal Change { get; set; } = default!;
        public decimal ChangePercent { get; set; } = default!;
    }
}
