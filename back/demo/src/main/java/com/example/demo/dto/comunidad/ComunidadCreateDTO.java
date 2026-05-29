package com.example.demo.dto.comunidad;

import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "Información para crear una comunidad")
public class ComunidadCreateDTO {

    private String nombre;
    private String direccion;

    public ComunidadCreateDTO() {
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
}
