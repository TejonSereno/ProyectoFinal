package com.example.demo.dto.comunidad;

import com.example.demo.models.Comunidad;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "Información de una comunidad")
public class ComunidadDTO {
    private Long id;
    private String nombre;
    private String direccion;

    public ComunidadDTO() {
    }

    public ComunidadDTO(Comunidad comunidad) {
        this.id = comunidad.getId();
        this.nombre = comunidad.getNombre();
        this.direccion = comunidad.getDireccion();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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
