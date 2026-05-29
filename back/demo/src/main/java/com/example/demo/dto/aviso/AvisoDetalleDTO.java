package com.example.demo.dto.aviso;

import com.example.demo.models.Aviso;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;

import java.time.LocalDateTime;

@Schema(description = "Información detallada de un aviso")
public class AvisoDetalleDTO {

    @Schema(example = "1")
    private Long id;

    @Schema(example = "Mantenimiento Piscina")
    private String titulo;

    @Schema(example = "La piscina estara cerrada al publico el dia 25/05/2026 por labores de mantenimiento")
    private String descripcion;

    @Schema(example = "2026-05-28T12:06:00")
    private LocalDateTime fechaCreacion;

    @Schema(example = "2026-05-30T12:06:00")
    private LocalDateTime fechaFin;

    @Schema(example = "1")
    private Long comunidadId;

    public AvisoDetalleDTO(){

    }

    public AvisoDetalleDTO(Aviso aviso){
        this.id = aviso.getId();
        this.descripcion = aviso.getDescripcion();
        this.fechaCreacion = aviso.getFechaCreacion();
        this.fechaFin = aviso.getFechaFin();
        this.comunidadId = aviso.getComunidad().getId();
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

    public LocalDateTime getFechaCreacion() {
        return fechaCreacion;
    }
    public void setFechaCreacion(LocalDateTime fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public LocalDateTime getFechaFin() {
        return fechaFin;
    }
    public void setFechaFin(LocalDateTime fechaFin) {
        this.fechaFin = fechaFin;
    }

    public Long getComunidadId() {
        return id;
    }
    public void setComunidadId(Long id) {
        this.comunidadId = id;
    }
}
