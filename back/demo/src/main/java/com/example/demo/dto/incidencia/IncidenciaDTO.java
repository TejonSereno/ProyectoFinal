package com.example.demo.dto.incidencia;

import com.example.demo.models.Incidencia;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "Información de una incidencia")
public class IncidenciaDTO {

    private Long id;
    private String titulo;
    private String descripcion;
    private String estado;

    public IncidenciaDTO() {
    }

    public IncidenciaDTO(Incidencia incidencia) {
        this.id = incidencia.getId();
        this.titulo = incidencia.getTitulo();
        this.descripcion = incidencia.getDescripcion();
        this.estado = incidencia.getEstado();
    }

    public IncidenciaDTO(Long id, String titulo, String descripcion, String estado) {
        this.id = id;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.estado = estado;
    }

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }
    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getEstado() {
        return estado;
    }
    public void setEstado(String estado) {
        this.estado = estado;
    }
}
