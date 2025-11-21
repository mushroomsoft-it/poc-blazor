using System;

namespace Frontend.Models;

public class OidcSettings
{
    public string Authority { get; set; } = string.Empty;
    public string ClientId { get; set; } = string.Empty;
    public string RedirectUri { get; set; } = string.Empty;
    public string PostLogoutRedirectUri { get; set; } = string.Empty;
    public string ResponseType { get; set; } = string.Empty;
    public List<string> DefaultScopes { get; set; } = new();

}
