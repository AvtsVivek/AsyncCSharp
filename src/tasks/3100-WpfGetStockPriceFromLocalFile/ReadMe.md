

- This builds from earlier wpf example.
 
- Here is another example which reads the data async ly and then desplays the data. 

- Here's a class here called DataStore, which uses a local file for the stock price lookup. Instead of querying the web resource, you could consider this being an offline cache. Inside the data store, there's a method called GetStockPrices. The method signature for GetStockPrices indicate that this is an asynchronous method. We can determine this by seeing that it returns a task of t. It also uses the async keyword, which means that somewhere in this method, there's an asynchronous call, which this method expects a result from. The purpose of this method is to interact with the file system in an asynchronous manner. Inspecting this further, we can see that it opens a stream to a file on disk and asynchronously requests each line in that file. If you want to consume this method, you'd use it very much like you did with the HttpClient. Head back to MainWindow.xaml.cs, remove all the usage of the HttpClient, and add a new instance of the DataStore class. To query for a particular stock, call the method GetStockPrices. This returns a task of a list of stock prices, and you should now know that to get the result from this asynchronous operation, you use the await keyword. Once the stock prices have been loaded from disk, you'll get the result, and it can be added to the data grid from the application to make sure that it still behaves the same. 

- 