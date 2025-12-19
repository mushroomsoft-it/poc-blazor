using System;
using System.Net;
using System.Net.Http.Json;
using Frontend.Models;
using Frontend.Services;
using Microsoft.AspNetCore.Components.WebAssembly.Authentication;
using Moq;
using Moq.Protected;

namespace Frontend.UnitTest;

public class EstudianteServiceTest
{
    [Fact]
    public async Task EstudianteService_Should_GetAllAsync()
    {

        // Arrange (data)
        var estudiantes = new List<Estudiante>
    {
        new Estudiante { Id = 1, Nombre = "Juan", Direccion = "Calle 1" },
        new Estudiante { Id = 2, Nombre = "Ana", Direccion = "Calle 2" }
    };

        // Fake HTTP
        var handlerMock = new Mock<HttpMessageHandler>(MockBehavior.Strict);

        handlerMock.Protected()
            .Setup<Task<HttpResponseMessage>>(
                "SendAsync",
                ItExpr.Is<HttpRequestMessage>(req =>
                    req.Method == HttpMethod.Get &&
                    req.RequestUri!.AbsolutePath == "/api/estudiante"
                ),
                ItExpr.IsAny<CancellationToken>())
            .ReturnsAsync(new HttpResponseMessage
            {
                StatusCode = HttpStatusCode.OK,
                Content = JsonContent.Create(estudiantes)
            });

        var httpClient = new HttpClient(handlerMock.Object)
        {
            BaseAddress = new Uri("http://localhost")
        };

        // Mock del token (forma correcta en .NET 8/9)
        var token = new AccessToken
        {
            Value = "fake-token",
            Expires = DateTimeOffset.UtcNow.AddMinutes(20)
        };

        var tokenResult = new AccessTokenResult(
            AccessTokenResultStatus.Success,
            token,
            null
        );

        var tokenProvider = new Mock<IAccessTokenProvider>();
        tokenProvider
            .Setup(tp => tp.RequestAccessToken())
            .ReturnsAsync(tokenResult);

        var service = new EstudianteService(httpClient, tokenProvider.Object);

        // Act
        var result = await service.GetAllAsync();

        // Assert
        Assert.NotNull(result);
        Assert.Equal(2, result.Count);
        Assert.Equal("Juan", result[0].Nombre);

        handlerMock.Verify();
    }

}
