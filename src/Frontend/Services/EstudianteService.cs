using System;
using System.Net.Http.Json;
using Frontend.Models;
using Microsoft.AspNetCore.Components.WebAssembly.Authentication;

namespace Frontend.Services;

public class EstudianteService
{
    private readonly HttpClient _http;
    private readonly IAccessTokenProvider _tokenProvider;
    public EstudianteService(HttpClient http, IAccessTokenProvider tokenProvider)
    {
        _http = http;
        _tokenProvider = tokenProvider;
    }

    public async Task<List<Estudiante>> GetAllAsync()
    {
        var result = await _tokenProvider.RequestAccessToken();
        if (result.TryGetToken(out var token))
        {
            _http.DefaultRequestHeaders.Authorization =
                new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token.Value);
        }
        return await _http.GetFromJsonAsync<List<Estudiante>>("api/estudiante") ?? new();
    }


    public async Task<Estudiante?> GetByIdAsync(int id)
    {
        var res = await _http.GetAsync($"api/estudiante/{id}");
        if (!res.IsSuccessStatusCode) return null;
        return await res.Content.ReadFromJsonAsync<Estudiante>();
    }

    public async Task<bool> CreateAsync(Estudiante e)
    {
        var res = await _http.PostAsJsonAsync("api/estudiante", e);
        return res.IsSuccessStatusCode;
    }

    public async Task<bool> UpdateAsync(Estudiante e)
    {
        var res = await _http.PutAsJsonAsync($"api/estudiante/{e.Id}", new
        {
            Id = e.Id,
            Nombre = e.Nombre,
            Direccion = e.Direccion
        });
        return res.IsSuccessStatusCode;
    }

    public async Task<bool> DeleteAsync(int id)
    {
        var res = await _http.DeleteAsync($"api/estudiante/{id}");
        return res.IsSuccessStatusCode;
    }
}
