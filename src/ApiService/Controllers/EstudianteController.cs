using ApiService.Data;
using ApiService.Dtos;
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

        [Authorize]
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
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
            if (!ModelState.IsValid) return BadRequest(ModelState);
            var e = new Estudiante { Nombre = dto.Nombre, Direccion = dto.Direccion };
            var created = await _repo.AddAsync(e);
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
    }
}
