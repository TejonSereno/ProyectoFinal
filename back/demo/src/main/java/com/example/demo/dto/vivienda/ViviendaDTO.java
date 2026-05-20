package com.example.demo.dto.vivienda;

import com.example.demo.models.Vivienda;

public class ViviendaDTO {

    private Long id;
    private String calle;
    private String numero;

    public ViviendaDTO() {
    }

    public ViviendaDTO(Vivienda vivienda) {
        this.id = vivienda.getId();
        this.calle = vivienda.getCalle();
        this.numero = vivienda.getNumero();
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
}
