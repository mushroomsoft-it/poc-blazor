using System;
using System.ComponentModel.DataAnnotations;

namespace ApiService.Dtos;

public class EstudianteUpdateDto
{
    [Required]
    public int Id { get; set; }

    [Required, StringLength(200)]
    public string Nombre { get; set; } = string.Empty;

    [Required, StringLength(300)]
    public string Direccion { get; set; } = string.Empty;
}
