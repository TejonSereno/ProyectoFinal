package com.example.demo.services;

import com.example.demo.dto.comunidad.ComunidadCreateDTO;
import com.example.demo.dto.comunidad.ComunidadDTO;
import com.example.demo.dto.comunidad.ComunidadDetalleDTO;
import com.example.demo.exceptions.ResourceNotFoundException;
import com.example.demo.models.Comunidad;
import com.example.demo.models.Usuario;
import com.example.demo.repositories.ComunidadRepository;
import com.example.demo.repositories.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ComunidadService {
    @Autowired
    private PasswordEncoder passwordEncoder;

    private final ComunidadRepository comunidadRepository;
    private final UsuarioRepository usuarioRepository;
    public ComunidadService(ComunidadRepository comunidadRepository, UsuarioRepository usuarioRepository) {
        this.comunidadRepository = comunidadRepository;
        this.usuarioRepository = usuarioRepository;
    }

    public List<ComunidadDTO> findAll(){
        return comunidadRepository.findAll()
                .stream()
                .map(ComunidadDTO::new)
                .toList();
    }

    public ComunidadDetalleDTO findById(Long id){
        Comunidad comunidad = comunidadRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Comunidad no encontrada"));
        return new ComunidadDetalleDTO(comunidad);
    }

    @Transactional
    public ComunidadDTO save(ComunidadCreateDTO dto){
        Comunidad comunidad = new Comunidad();
        comunidad.setNombre(dto.getNombre());
        comunidad.setDireccion(dto.getDireccion());
        comunidadRepository.save(comunidad);

        Usuario admin = new Usuario();
        admin.setNombre("Admin");
        admin.setEmail("admin_" + comunidad.getId() + "@test.com");
        admin.setPassword(passwordEncoder.encode("1234"));
        admin.setRol("ADMIN");
        admin.setComunidad(comunidad);
        usuarioRepository.save(admin);

        return new ComunidadDTO(comunidad);
    }

    public ComunidadDTO update(Long id, ComunidadCreateDTO dto) {
        Comunidad comunidad = comunidadRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Comunidad no encontrada"));
        comunidad.setNombre(dto.getNombre());
        comunidad.setDireccion(dto.getDireccion());
        return new ComunidadDTO(comunidadRepository.save(comunidad));
    }

    public void delete(Long id){
        if (!comunidadRepository.existsById(id)) {
            throw new ResourceNotFoundException("Comunidad no existe");
        }
        comunidadRepository.deleteById(id);
    }
}
