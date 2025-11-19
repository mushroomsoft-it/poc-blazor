using System;
using ApiService.Models;

namespace ApiService.Respositories;

public interface IEstudianteRepository
{
    Task<List<Estudiante>> GetAllAsync();
    Task<Estudiante?> GetByIdAsync(int id);
    Task<Estudiante> AddAsync(Estudiante e);
    Task<bool> UpdateAsync(Estudiante e);
    Task<bool> DeleteAsync(int id);
}
