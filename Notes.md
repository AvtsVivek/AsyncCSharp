Async Programming in C#

- The **async** keyword is the way for you to indicate that this method will contain asynchronous operations. 

- The **await** keyword is a way to indicate that we want to come back to the code and execute everything after the method call prifixed with await keyword.

- An asynchronous operation occurs in parallel and relieves the calling thread of the 
work. 

- The keywords **async** and **await** are used together.

- Asynchronous principles are suitable for any type of I/O operations. Asynchronous programming is good for 
  - reading and writing from disk, 
  - memory, 
  - things like database operations and 
  - interacting with a web API. 

- Then what about CPU bound operations? For that, you'd use parallel programming, which is a way to divide a problem into smaller pieces that are all solved independently while making use of as much computer power as possible. 

- While an asynchronous operation do occur in parallel, the distinct difference is that within asynchronous operation, you subscribe to when that operation completes. The Task Parallel Library allows for both asynchronous, as well as parallel programming

- Consider the following.

```cs
private async void Search_Click(object sender, RoutedEventArgs e)
{
    BeforeLoadingStockData();

    using (var client = new HttpClient())
    {
        Task<HttpResponseMessage> responseTask = client.GetAsync($"{API_URL}/{StockIdentifier.Text}");

        var response = await responseTask;

        var content = await response.Content.ReadAsStringAsync();

        var data = JsonConvert.DeserializeObject<IEnumerable<StockPrice>>(content);

        Stocks.ItemsSource = data;
    }

    AfterLoadingStockData();
}
```
- In the following line of code, client.GetAsync returns a Task. 

```cs
Task<HttpResponseMessage> responseTask = client.GetAsync($"{API_URL}/{StockIdentifier.Text}");
```
- A Task is a representation of Async operation. 
  
- The variable responseTask is a reference to the ongoing async operation.

- Now how to get the response? One way is to call **Result** property as follows.

```cs
Task<HttpResponseMessage> responseTask = client.GetAsync($"{API_URL}/{StockIdentifier.Text}");

var response = responseTask.Result; // blocks the thread.

```

- But this is a bad idea. What happens when you request the result using this property is that it will **block the thread until the result is available**. This means that it will run the code synchronously. 

- So how do we get the HttpResponseMessage, then only proceed executing the rest of the method when that operation has completed? 

- This is where we introduce the **await** keyword. Await is a way to indicate that we want to get the result from the asynchronous operation once the data is available, and most important of all, without blocking the current thread. As you see, adding the await gives you the HttpResponseMessage. This value will be available as soon as the web request has completed. 

```cs
Task<HttpResponseMessage> responseTask = client.GetAsync($"{API_URL}/{StockIdentifier.Text}");

var response = await responseTask;
```

- The await keyword will pause execution of the method unitl a result is available, without blocking the calling(UI) thread. Only after the async operation is completed, the next line will be executed.

- So once the web request completed, the next line following the async operation(with await) is executed.

```cs
var response = await responseTask;
var content = await response.Content.ReadAsStringAsync();
```

- 

- Calling Result or Wait() may cause a deadlock, so avoid.

- Next we have again an async operation to read the content from the response.

```cs
var content = await response.Content.ReadAsStringAsync();
```

- 