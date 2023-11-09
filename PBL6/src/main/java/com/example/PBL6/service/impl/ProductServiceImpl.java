package com.example.PBL6.service.impl;

import com.example.PBL6.dto.cart.CartResponseDto;
import com.example.PBL6.dto.product.FaProductRespDto;
import com.example.PBL6.dto.product.ProductRequestDto;
import com.example.PBL6.dto.product.ProductResponseDto;
import com.example.PBL6.persistance.product.FavouriteProduct;
import com.example.PBL6.persistance.product.Product;
import com.example.PBL6.persistance.product.ProductVariant;
import com.example.PBL6.persistance.user.User;
import com.example.PBL6.repository.CategoryRepository;
import com.example.PBL6.repository.FavouriteProductRepository;
import com.example.PBL6.repository.ProductRepository;
import com.example.PBL6.repository.ProductVariantRepository;
import com.example.PBL6.service.ProductService;
import jakarta.transaction.Transactional;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private ProductVariantRepository productVariantRepository;
    @Autowired
    private FavouriteProductRepository favouriteProductRepository;
    @Autowired
    private ModelMapper modelMapper;


    @Override
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    @Override
    public Page<ProductResponseDto> getAllProducts(@PageableDefault(size = 4) Pageable pageable) {
        Page<Product> productPage = productRepository.findAll(pageable);
        return productPage.map(product -> modelMapper.map(product, ProductResponseDto.class));
    }

    @Transactional
    @Override
    public ProductResponseDto addProduct(ProductRequestDto productRequestDto) {
        Optional<Product> productCheck = productRepository.findProductByName(productRequestDto.getName());
        Product product;
        Product productResponse;
        ProductResponseDto productResponseDto;
        if (!productCheck.isPresent()) {
            product = Product.builder()
                    .name(productRequestDto.getName())
                    .description(productRequestDto.getDescription())
                    .price(productRequestDto.getPrice())
                    .discount(productRequestDto.getDiscount())
                    .image(productRequestDto.getImageUrl())
                    .category(categoryRepository.getById(productRequestDto.getCategoryId()))
                    .createDate(LocalDateTime.now())
                    .updateDate(LocalDateTime.now())
                    .build();
            productResponse = productRepository.save(product);
            ProductVariant productVariant = new ProductVariant().builder()
                    .quantity(productRequestDto.getQuantity())
                    .color(productRequestDto.getColor())
                    .size(productRequestDto.getSize())
                    .product(productResponse)
                    .build();
            productVariantRepository.save(productVariant);
            productResponseDto = new ProductResponseDto().builder()
                    .product(productResponse)
                    .build();
        } else {
            productResponse = productCheck.get();
            Integer productId = productCheck.get().getId();
            String color = productRequestDto.getColor();
            String size = productRequestDto.getSize();
            Integer quantity = productRequestDto.getQuantity();
            if (productVariantRepository.countByProductIdAndColorAndSize(productId, color, size) == 0) {
                productVariantRepository.addProductVariantIfExistProduct(productId, color, size, quantity);
            } else {
                productVariantRepository.addQuantity(productId, quantity);
            }
            productResponseDto = new ProductResponseDto().builder()
                    .product(productResponse)
                    .build();
        }
        List<ProductVariant> productVariants = productVariantRepository.getAllByProduct(productResponseDto.getProduct());
        productResponseDto.setProductVariants(productVariants);

        return productResponseDto;
    }

    @Override
    public ProductResponseDto getDetailProduct(Integer id) {
        Optional<Product> product = productRepository.findById(id);
        List<ProductVariant> productVariants;
        if (product.isPresent()) {
            productVariants = productVariantRepository.getAllByProduct(product.get());
        } else {
            return null;
        }
        ProductResponseDto productResponseDto = new ProductResponseDto()
                .builder()
                .product(product.get())
                .productVariants(productVariants)
                .build();
        return productResponseDto;
    }

    @Override
    public List<Product> getFavouriteProducts(User user) {
        List<FavouriteProduct> favouriteProducts = favouriteProductRepository.getFavouriteProductsByUser(user);
        if (favouriteProducts.size() > 0) {
            List<Product> products = new ArrayList<>();
            for (FavouriteProduct favouriteProduct : favouriteProducts) {
                products.add(favouriteProduct.getProduct());
            }
            return products;
        }
        return null;
    }

    @Override
    @Transactional
    public FaProductRespDto addFavouriteProduct(User user, Integer id) {
        boolean check = favouriteProductRepository.existsFavouriteProductByUserAndProduct(user,
                productRepository.getById(id));
        if(check != true) {
            FavouriteProduct favouriteProduct = new FavouriteProduct().builder()
                    .product(productRepository.getById(id))
                    .user(user)
                    .build();
            FavouriteProduct favouriteProductSave = favouriteProductRepository.save(favouriteProduct);
            return favouriteProductSave != null ? new FaProductRespDto("Thêm sản phẩm yêu thích thành công") :
                    new FaProductRespDto("Thêm sản phẩm yêu thích thất bại");
        } else {
            return new FaProductRespDto("Sản phẩm đã tồn tại trong mục sản phẩm yêu thích");
        }
    }

    @Override
    @Transactional
    public FaProductRespDto deleteFavouriteProduct(User user, Integer id) {
        favouriteProductRepository.deleteById(id);
        return new FaProductRespDto("Xóa thành công");
    }

    @Override
    @Transactional
    public FaProductRespDto deleteAllFavouriteProducts(User user) {
        favouriteProductRepository.deleteAllByUser(user);
        return new FaProductRespDto("Xóa toàn bộ thành công");
    }
}
