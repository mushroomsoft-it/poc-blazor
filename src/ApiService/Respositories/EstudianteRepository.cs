using System;
using ApiService.Data;
using ApiService.Models;
using Microsoft.EntityFrameworkCore;

namespace ApiService.Respositories;

public class EstudianteRepository : IEstudianteRepository
{
    private readonly AppDbContext _db;
    public EstudianteRepository(AppDbContext db) => _db = db;

    public async Task<List<Estudiante>> GetAllAsync() =>
        await _db.Estudiantes.AsNoTracking().ToListAsync();

    public async Task<Estudiante?> GetByIdAsync(int id) =>
        await _db.Estudiantes.FindAsync(id);

    public async Task<Estudiante> AddAsync(Estudiante e)
    {
        _db.Estudiantes.Add(e);
        await _db.SaveChangesAsync();
        return e;
    }

    public async Task<bool> UpdateAsync(Estudiante e)
    {
        var exists = await _db.Estudiantes.AnyAsync(x => x.Id == e.Id);
        if (!exists) return false;
        _db.Estudiantes.Update(e);
        await _db.SaveChangesAsync();
        return true;
    }

    public async Task<bool> DeleteAsync(int id)
    {
        var e = await _db.Estudiantes.FindAsync(id);
        if (e == null) return false;
        _db.Estudiantes.Remove(e);
        await _db.SaveChangesAsync();
        return true;
    }
}
