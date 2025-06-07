package base.api.book.service;


import base.api.book.dto.*;
import base.api.book.dto.search.ListingSearchByOwnerAndNameDto;
import base.api.book.dto.search.ListingSearchDto;
import base.api.book.entity.Book;
import base.api.book.entity.Copy;
import base.api.book.entity.Listing;
import base.api.book.entity.support.CopyStatus;
import base.api.book.entity.support.ListingStatus;
import base.api.book.mapper.BookMapper;
import base.api.book.mapper.CopyMapper;
import base.api.book.mapper.ListingMapper;
import base.api.book.repository.BookRepository;
import base.api.book.repository.CopyRepository;
import base.api.book.repository.ListingRepository;
import base.api.user.UserService;
import base.api.user.internal.repository.UserRepository;
import jakarta.transaction.Transactional;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Transactional
public class ListingService {
    private final ListingMapper listingMapper;
    private final ListingRepository listingRepository;

    private final CopyRepository copyRepository;

    private final CopyMapper copyMapper;
    private final UserRepository userRepository;


    public ListingService(ListingMapper listingMapper, ListingRepository listingRepository, CopyRepository copyRepository, CopyMapper copyMapper, UserRepository userRepository) {
        this.listingMapper = listingMapper;
        this.listingRepository = listingRepository;
        this.copyRepository = copyRepository;
        this.copyMapper = copyMapper;
        this.userRepository = userRepository;
    }

    public ListingDto createListing (ListingDto listingDto) {
        Listing listing = listingMapper.toEntity(listingDto);
        listing.setCopy(copyRepository.getReferenceById(listing.getCopy().getId()));
        listing.setOwner(userRepository.getReferenceById(listing.getOwner().getId()));
        Listing createdListing = listingRepository.save(listing);
//        update status copy
        Copy copy = copyRepository.getReferenceById(createdListing.getCopy().getId());
//        CopyDto copyDto = copyMapper.toDto(copy);
//        Copy newCopy = copyMapper.toEntity(copyDto);
//        newCopy.setId(listingDto.copyId());
        copy.setCopyStatus(CopyStatus.LISTED);
        copyRepository.save(copy);
        return listingMapper.toDto(createdListing);
    }

    public ListingDto getListingById (Long id) {
        Optional<Listing> optionalListing = listingRepository.findById(id);
        return optionalListing.map(listingMapper::toDto).orElse(null);
    }

    public Page<ListingDto> getListingByOwnerId (Pageable pageable, Long id) {
        Page<Listing> listing = listingRepository.findListingByOwnerId(pageable,id);
        return listing.map(listingMapper::toDto);
    }

    public List<ListingDto> getAllListing () {
        return listingRepository
                .findAll()
                .stream()
                .map(listingMapper::toDto)
                .toList();
    }

    public Page<ListingDto> findListings(Pageable pageable, ListingSearchDto searchDto) {
        Page<Listing> result;
        if (StringUtils.isNoneBlank(searchDto.getTitle(), searchDto.getGenre())) {
            result = listingRepository.findByTitleLikeAndGenre(pageable, searchDto.getTitle(), searchDto.getGenre(),searchDto.getAllowRent(), searchDto.getAllowPurchase());
        } else if (StringUtils.isNoneBlank(searchDto.getTitle()) && StringUtils.isBlank(searchDto.getGenre())) {
            result = listingRepository.findByTitle(pageable, searchDto.getTitle(), searchDto.getAllowRent(), searchDto.getAllowPurchase());
        } else if (StringUtils.isBlank(searchDto.getTitle()) && StringUtils.isNotBlank(searchDto.getGenre())) {
            result = listingRepository.findByGenre(pageable, searchDto.getGenre(), searchDto.getAllowRent(), searchDto.getAllowPurchase());
        } else {
            result = listingRepository.findByListingStatus(pageable,ListingStatus.AVAILABLE);
        }

        return result.map(listingMapper::toDto);
    }

    public ListingDto updateListing (ListingDto listingDto) {
        Long id = listingDto.id();
        Listing newListing = listingMapper.toEntity(listingDto);
        newListing.setId(id);
        Listing createdListing = listingRepository.save(newListing);
        return listingMapper.toDto(createdListing);
    }

    public void deleteListing (Long id) {
        listingRepository.deleteById(id);
    }

    public Long countListingByOwner(Long ownerId) {
        return listingRepository.countListingByOwnerId(ownerId);
    }

    public Long countListingByOwnerAndStatus(Long ownerId) {
        return listingRepository.countListingByOwnerIdAndListingStatus(ownerId,ListingStatus.LEASED);
    }

    public Page<ListingDto> getListingByOwnerIdAndTitleContainer (Pageable pageable,ListingSearchByOwnerAndNameDto listingSearch) {
        Page<Listing> result = listingRepository.findByIdAndBookTitleContaining(pageable,listingSearch.getOwnerId(), listingSearch.getTitle());
        return result.map(listingMapper::toDto);
    }

    public ListingDto editStatus (EditStatusListingRequest statusRequest) {
        Long Listing_id = statusRequest.id();
        Listing listing = listingRepository.findById(Listing_id).get();
        Copy copy = listing.getCopy();
        Long copy_id = copy.getId();
        return null;

    }


}
