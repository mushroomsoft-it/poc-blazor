using System;
using System.Net.Http.Json;
using Frontend.Models;

namespace Frontend.Services;

public class EstudianteService
{
    private readonly HttpClient _http;
    public EstudianteService(HttpClient http) => _http = http;

    public async Task<List<Estudiante>> GetAllAsync()
        => await _http.GetFromJsonAsync<List<Estudiante>>("api/estudiante") ?? new();

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
