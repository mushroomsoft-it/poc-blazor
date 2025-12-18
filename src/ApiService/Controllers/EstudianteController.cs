using ApiService.Data;
using ApiService.Dtos;
using ApiService.Metrics;
using ApiService.Models;
using ApiService.Respositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ApiService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EstudianteController : ControllerBase
    {
        private readonly IEstudianteRepository _repo;
        private readonly ILogger<EstudianteController> _log;
        public EstudianteController(IEstudianteRepository repo, ILogger<EstudianteController> log)
        {
            _repo = repo;
            _log = log;
        }

        [Authorize(Roles = "admin")]
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            _log.LogInformation("Obteniendo la lista de estudiantes");
            var list = await _repo.GetAllAsync();
            return Ok(list);
        }

        [HttpGet("{id:int}")]
        public async Task<IActionResult> Get(int id)
        {
            var e = await _repo.GetByIdAsync(id);
            if (e == null) return NotFound();
            return Ok(e);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] EstudianteCreateDto dto)
        {
            _log.LogInformation("Creando un nuevo estudiante");
            AppMetrics.EstudiantesCreados.Add(1);
            if (!ModelState.IsValid) return BadRequest(ModelState);
            var e = new Estudiante { Nombre = dto.Nombre, Direccion = dto.Direccion };
            var created = await _repo.AddAsync(e);
            AppMetrics.EstudianteDuration.Record(50.0); // Simulated processing time
            return CreatedAtAction(nameof(Get), new { id = created.Id }, created);
        }

        [HttpPut("{id:int}")]
        public async Task<IActionResult> Update(int id, [FromBody] EstudianteUpdateDto dto)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);
            if (id != dto.Id) return BadRequest("Id mismatch");
            var e = new Estudiante { Id = dto.Id, Nombre = dto.Nombre, Direccion = dto.Direccion };
            var ok = await _repo.UpdateAsync(e);
            if (!ok) return NotFound();
            return NoContent();
        }

        [HttpDelete("{id:int}")]
        public async Task<IActionResult> Delete(int id)
        {
            var ok = await _repo.DeleteAsync(id);
            if (!ok) return NotFound();
            return NoContent();
        }

        [HttpGet("error")]
        public IActionResult ForceError()
        {
            AppMetrics.EstudianteErrors.Add(1);

            _log.LogError("❌ Error simulado");

            throw new InvalidOperationException("Error simulado");
        }
    }
}
