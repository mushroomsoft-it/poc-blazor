using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using Frontend;
using Frontend.Services;
using Frontend.Models;
using System.Net.Http.Json;

var builder = WebAssemblyHostBuilder.CreateDefault(args);
builder.RootComponents.Add<App>("#app");
builder.RootComponents.Add<HeadOutlet>("head::after");

// Cargar configuración dinámica desde wwwroot/config/appsettings.json
var http = new HttpClient { BaseAddress = new Uri(builder.HostEnvironment.BaseAddress) };
var config = await http.GetFromJsonAsync<AppConfig>("config/appsettings.json");

// Registrar la configuración para DI
builder.Services.AddSingleton(config);

// HttpClient con BaseUrl dinámico
builder.Services.AddScoped(sp => new HttpClient
{
    BaseAddress = new Uri(config.BaseUrl)
});

// Cargar configuración OIDC
builder.Services.AddOidcAuthentication(options =>
{
    options.ProviderOptions.Authority = config.Authentication.AWS.Authority;
    options.ProviderOptions.ClientId = config.Authentication.AWS.ClientId;
    options.ProviderOptions.ResponseType = "code";
    options.ProviderOptions.DefaultScopes.Clear();

    foreach (var scope in config.Authentication.AWS.DefaultScopes)
        options.ProviderOptions.DefaultScopes.Add(scope);

    if (!string.IsNullOrEmpty(config.Authentication.AWS.RedirectUri))
        options.ProviderOptions.RedirectUri = config.Authentication.AWS.RedirectUri;

    if (!string.IsNullOrEmpty(config.Authentication.AWS.PostLogoutRedirectUri))
        options.ProviderOptions.PostLogoutRedirectUri = config.Authentication.AWS.PostLogoutRedirectUri;

    if (!string.IsNullOrEmpty(config.Authentication.AWS.MetadataUrl))
        options.ProviderOptions.MetadataUrl = config.Authentication.AWS.MetadataUrl;
});

// Tus servicios
builder.Services.AddScoped<EstudianteService>();

await builder.Build().RunAsync();
