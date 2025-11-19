using System;
using ApiService.Models;
using Microsoft.EntityFrameworkCore;

namespace ApiService.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
    {

    }

    public DbSet<Estudiante> Estudiantes { get; set; } = null!;
}
