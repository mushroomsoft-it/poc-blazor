using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using Frontend;
using Frontend.Services;

var builder = WebAssemblyHostBuilder.CreateDefault(args);
builder.RootComponents.Add<App>("#app");
builder.RootComponents.Add<HeadOutlet>("head::after");

string baseAddress = builder.Configuration.GetValue<string>("BaseUrl") ?? "http://localhost:5001";

builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri(baseAddress) });
builder.Services.AddScoped<EstudianteService>();

await builder.Build().RunAsync();
