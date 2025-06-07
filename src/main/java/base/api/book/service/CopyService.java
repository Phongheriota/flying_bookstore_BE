package base.api.book.service;

import base.api.book.dto.CopyDto;
import base.api.book.entity.Copy;
import base.api.book.entity.support.CopyStatus;
import base.api.book.mapper.CopyMapper;
import base.api.book.repository.CopyRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Transactional
public class CopyService {
    private final CopyRepository copyRepository;
    private final CopyMapper copyMapper;

    public CopyService(CopyRepository copyRepository, CopyMapper copyMapper) {
        this.copyRepository = copyRepository;
        this.copyMapper = copyMapper;
    }

    public CopyDto createCopy (CopyDto copyDto) {
        Copy copy = copyMapper.toEntity(copyDto);
        Copy newCopy = copyRepository.save(copy);
        return copyMapper.toDto(newCopy);
    }

    public CopyDto getCopyById (Long id) {
        Optional<Copy> optionalCopy= copyRepository.findById(id);
        return optionalCopy.map(copyMapper::toDto).orElse(null);
     }
    public List<CopyDto> getAllCopy () {
        return copyRepository
                .findAll()
                .stream()
                .map(copyMapper::toDto)
                .collect(Collectors.toList());
    }

    public Page<CopyDto> findAllCopies(Pageable pageable) {
        return copyRepository.findAll(pageable).map(copyMapper::toDto);
    }

    public List<CopyDto> getCopyByOwnerId (Long ownerId) {
        return copyRepository
                .findByOwnerIdAndCopyStatus(ownerId, CopyStatus.UNLISTED)
                .stream()
                .map(copyMapper::toDto)
                .collect(Collectors.toList());
    }

    public CopyDto updateCopy (CopyDto copyDto) {
        Long id = copyDto.id();
        Copy copy = copyMapper.toEntity(copyDto);
        copy.setId(id);
        Copy createdCopy = copyRepository.save(copy);
        return copyMapper.toDto(createdCopy);
    }

    public void deleteCopy (Long id) {
        copyRepository.deleteById(id);
    }


//    public String[] getImgReview (Long id) {
//        if (copyRepository.findById(id).isPresent()) {
//            Copy copy = copyRepository.findById(id).get();
//            return copy.getImgReview();
//        }
//        return null;
//    }



}
