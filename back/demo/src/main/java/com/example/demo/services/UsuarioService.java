package com.example.demo.services;

import com.example.demo.dto.LoginRequest;
import com.example.demo.dto.RegistreRequest;
import com.example.demo.dto.usuario.*;
import com.example.demo.exceptions.ResourceNotFoundException;
import com.example.demo.models.Usuario;
import com.example.demo.repositories.ComunidadRepository;
import com.example.demo.repositories.UsuarioRepository;
import com.example.demo.repositories.ViviendaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UsuarioService {

    @Autowired
    private PasswordEncoder passwordEncoder;

    private final UsuarioRepository usuarioRepository;
    private final ComunidadRepository comunidadRepo;
    private final ViviendaRepository viviendaRepo;
    public UsuarioService(UsuarioRepository usuarioRepository, ComunidadRepository comunidadRepository, ViviendaRepository viviendaRepository) {
        this.usuarioRepository = usuarioRepository;
        this.comunidadRepo = comunidadRepository;
        this.viviendaRepo = viviendaRepository;
    }

    public List<UsuarioDTO> findAll(){
        return usuarioRepository.findAll()
                .stream()
                .map(UsuarioDTO::new)
                .toList();
    }

    public List<UsuarioListadoDTO> finAllListado(){
        return usuarioRepository.findAllListado();
    }

    public UsuarioDetalleDTO findById(Long id){
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado"));
        return new UsuarioDetalleDTO(usuario);
    }

    public UsuarioDetalleDTO findByEmail(String email){
        Usuario usuario = usuarioRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado"));
        return new UsuarioDetalleDTO(usuario);
    }

    public UsuarioDTO save(UsuarioCreateDTO dto){
        if (usuarioRepository.existsByEmail(dto.getEmail())) {
            throw new ResourceNotFoundException("El email ya está registrado");
        }
        Usuario usuario = new Usuario();
        usuario.setNombre(dto.getNombre());
        usuario.setEmail(dto.getEmail());
        usuario.setPassword(passwordEncoder.encode(dto.getPassword()));
        usuario.setRol(dto.getRol());
        usuario.setComunidad(
                comunidadRepo.findById(dto.getComunidadId())
                        .orElseThrow(() -> new ResourceNotFoundException("Comunidad no encontrada"))
        );
        return new UsuarioDTO(usuarioRepository.save(usuario));
    }

    public UsuarioDTO update(Long id, UsuarioUpdateDTO dto){
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado"));
        usuario.setNombre(dto.getNombre());
        usuario.setEmail(dto.getEmail());
        usuario.setPassword(passwordEncoder.encode(dto.getPassword()));
        return new UsuarioDTO(usuarioRepository.save(usuario));
    }

    public void delete(Long id){
        if (!usuarioRepository.existsById(id)) {
            throw new ResourceNotFoundException("Usuario no existe");
        }
        usuarioRepository.deleteById(id);
    }

    public UsuarioDetalleDTO login(LoginRequest loginRequest){
        Usuario usuario = usuarioRepository.findByEmail(loginRequest.getEmail())
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado"));
        if (!passwordEncoder.matches(loginRequest.getPassword(), usuario.getPassword())) {
            throw new ResourceNotFoundException("Contraseña incorrecta");
        }
        return new UsuarioDetalleDTO(usuario);
    }

    public UsuarioDetalleDTO registre(RegistreRequest registreRequest){
        if (usuarioRepository.existsByEmail(registreRequest.getEmail())) {
            throw new ResourceNotFoundException("El email ya está registrado");
        }

        Usuario user = new Usuario();
        user.setNombre(registreRequest.getNombre());
        user.setEmail(registreRequest.getEmail());
        user.setPassword(passwordEncoder.encode(registreRequest.getPassword()));
        user.setRol("USER");
        user.setVivienda(
                viviendaRepo.findById(1L)
                        .orElseThrow(() -> new ResourceNotFoundException("Vivienda no encontrada"))
        );
        user.setComunidad(
                comunidadRepo.findById(1L)
                        .orElseThrow(() -> new ResourceNotFoundException("Comunidad no encontrada"))
        );
        return new UsuarioDetalleDTO(usuarioRepository.save(user));
    }

    public Boolean existsByEmail(String email){
        return usuarioRepository.existsByEmail(email);
    }

    public void updateRol(Long id) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado"));
        if ("ADMIN".equals(usuario.getRol())) {
            usuario.setRol("USER");
        } else {
            usuario.setRol("ADMIN");
        }
        usuarioRepository.save(usuario);
    }
}
