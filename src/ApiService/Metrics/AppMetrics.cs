using System;
using System.Diagnostics.Metrics;

namespace ApiService.Metrics;

public static class AppMetrics
{
    public static readonly Meter Meter =
        new Meter("MyApp.Metrics", "1.0.0");

    public static readonly Counter<long> EstudiantesCreados =
        Meter.CreateCounter<long>(
            "estudiante_created_total",
            description: "Total de estudiantes creados");

    public static readonly Histogram<double> EstudianteDuration =
        Meter.CreateHistogram<double>(
            "estudiante_processing_duration_ms",
            unit: "ms",
            description: "Duración de procesamiento de estudiante");

    public static readonly Counter<long> EstudianteErrors =
        Meter.CreateCounter<long>(
            "estudiante_errors_total", description: "Total de errores en estudiantes");

}