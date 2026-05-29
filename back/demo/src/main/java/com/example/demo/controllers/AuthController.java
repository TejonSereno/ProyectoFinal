package com.example.demo.controllers;

import com.example.demo.dto.AuthResponse;
import com.example.demo.dto.LoginRequest;
import com.example.demo.dto.RegistreRequest;
import com.example.demo.dto.usuario.UsuarioDetalleDTO;
import com.example.demo.services.UsuarioService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/auth")
@Tag(name = "Autentificacion", description = "Operaciones de autentificacion")
public class AuthController {

    private final UsuarioService usuarioService;

    public AuthController(UsuarioService usuarioService){
        this.usuarioService = usuarioService;
    }

    @Operation(
            summary = "Logear usuario",
            responses = {
                    @ApiResponse(responseCode = "200", description = "EL usuario se logueo con exito")
            }
    )
    @PostMapping("/login")
    public AuthResponse login(
            @RequestBody LoginRequest request
    ) {
        return usuarioService.login(request);
    }

    @Operation(
            summary = "Registrar nuevo usuario",
            responses = {
                    @ApiResponse(responseCode = "200", description = "Usuario registrado coon exito"),

            }
    )
    @PostMapping("/register")
    public UsuarioDetalleDTO register(
            @RequestBody RegistreRequest request
    ) {
        return usuarioService.registre(request);
    }
}
