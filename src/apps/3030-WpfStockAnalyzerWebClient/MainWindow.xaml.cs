using Newtonsoft.Json;
using System.Collections.Generic;
using System.Diagnostics;
using System.Net;
using System.Threading;
using System.Windows;
using System.Windows.Navigation;

namespace WpfStockAnalyzerWebClient
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private readonly string API_URL = "https://ps-async.fekberg.com/api/stocks";
        private Stopwatch stopwatch = new();

        public MainWindow()
        {
            InitializeComponent();
        }

        private void Search_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(StockIdentifier.Text))
            {
                StocksStatus.Text = "Please enter stock identifier ";
                return;
            }

            BeforeLoadingStockData();

            var client = new WebClient();

            var content = client.DownloadString($"{API_URL}/{StockIdentifier.Text}");

            // Simulate that the web call takes a very long time
            Thread.Sleep(10000);

            var data = JsonConvert.DeserializeObject<IEnumerable<StockPrice>>(content);

            Stocks.ItemsSource = data;

            AfterLoadingStockData();
        }

        private void BeforeLoadingStockData()
        {
            stopwatch.Restart();
            StockProgress.Visibility = Visibility.Visible;
            StockProgress.IsIndeterminate = true;
        }

        private void AfterLoadingStockData()
        {
            StocksStatus.Text = $"Loaded stocks for {StockIdentifier.Text} in {stopwatch.ElapsedMilliseconds}ms";
            StockProgress.Visibility = Visibility.Hidden;
        }

        private void Hyperlink_OnRequestNavigate(object sender, RequestNavigateEventArgs e)
        {
            Process.Start(new ProcessStartInfo { FileName = e.Uri.AbsoluteUri, UseShellExecute = true });

            e.Handled = true;
        }

        private void Close_OnClick(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }
    }
}
