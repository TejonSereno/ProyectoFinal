package com.example.demo.dto.vivienda;

import com.example.demo.models.Vivienda;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "Información para listar viviendas")
public class ViviendaListadoDTO {
    private Long id;
    private String calle;
    private String numero;
    private Long nUsuarios;

    public ViviendaListadoDTO() {
    }

    public ViviendaListadoDTO(Long id, String calle, String numero, Long nUsuarios) {
        this.id = id;
        this.calle = calle;
        this.numero = numero;
        this.nUsuarios = nUsuarios;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCalle() {
        return calle;
    }

    public void setCalle(String calle) {
        this.calle = calle;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public Long getNUsuarios() {
        return nUsuarios;
    }

    public void setNUsuarios(Long nUsuarios) {
        this.nUsuarios = nUsuarios;
    }
}
