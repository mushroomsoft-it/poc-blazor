using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using Frontend;
using Frontend.Services;
using Frontend.Models;

var builder = WebAssemblyHostBuilder.CreateDefault(args);
builder.RootComponents.Add<App>("#app");
builder.RootComponents.Add<HeadOutlet>("head::after");

string baseAddress = builder.Configuration.GetValue<string>("BaseUrl") ?? "http://localhost:5001";

builder.Services.Configure<OidcSettings>(options =>
    builder.Configuration.GetSection("Authentication:AWS").Bind(options));

builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri(baseAddress) });
builder.Services.AddScoped<EstudianteService>();

builder.Services.AddOidcAuthentication(options =>
{
    builder.Configuration.Bind("Authentication:AWS", options.ProviderOptions);
    options.ProviderOptions.ResponseType = "code";

});

await builder.Build().RunAsync();
