import 'product_model.dart';

class ProductData {
  static final Map<String, String> _productDescriptions = {
    // Молочные продукты
    'Молоко Простоквашино': 'Свежее пастеризованное молоко от бренда Простоквашино. Натуральный продукт высокого качества.',
    'Сыр Российский': 'Классический российский сыр с нежным вкусом и приятной консистенцией.',
    'Масло сливочное': 'Натуральное сливочное масло высшего сорта, идеально подходит для выпечки и бутербродов.',
    'Йогурт Активиа': 'Йогурт с полезными бактериями, способствующими улучшению пищеварения.',
    'Кефир Домик в деревне': 'Классический кефир, приготовленный по традиционной технологии.',

    // Хлебобулочные изделия
    'Хлеб Бородинский': 'Ржаной хлеб с насыщенным вкусом и ароматом, приготовленный по традиционному рецепту.',
    'Батон нарезной': 'Мягкий пшеничный батон, идеально подходящий для бутербродов.',
    'Круассаны': 'Воздушные французские круассаны с хрустящей корочкой.',

    // Мясные продукты
    'Колбаса Докторская': 'Вареная колбаса из высококачественного мяса, с нежной текстурой.',
    'Курица охлажденная': 'Свежая охлажденная курица, отличного качества.',
    'Свинина для жарки': 'Нежное мясо для приготовления вкусных горячих блюд.',

    // Яйца
    'Яйца куриные': 'Свежие яйца от домашних кур, богатые белком.',
    'Перепелиные яйца': 'Маленькие, но очень полезные яйца с насыщенным вкусом.',

    // Овощи
    'Помидоры свежие': 'Спелые, сочные помидоры с насыщенным вкусом.',
    'Огурцы': 'Свежие хрустящие огурцы, идеальны для салатов.',
    'Картофель': 'Качественный картофель для любых кулинарных целей.',

    // Фрукты
    'Бананы': 'Спелые сладкие бананы, богатые калием и витаминами.',
    'Яблоки Голден': 'Сладкие и сочные яблоки сорта Голден.',
  };

  static List<Product> getProducts() {
    return [
      // Молочные продукты
      Product(
        id: '1',
        name: 'Молоко Простоквашино', 
        image: 'lib/images/milk.jpg', 
        price: 89.99, 
        category: 'Молочные продукты',
        description: _productDescriptions['Молоко Простоквашино'] ?? 'Описание отсутствует'
      ),
      Product(
        id: '2',
        name: 'Сыр Российский', 
        image: 'lib/images/russia_cheese.png', 
        price: 89.99, 
        category: 'Молочные продукты',
        description: _productDescriptions['Сыр Российский'] ?? 'Описание отсутствует'
      ),
      Product(
        id: '3',
        name: 'Масло сливочное', 
        image: 'lib/images/maslo_s.png', 
        price: 89.99, 
        category: 'Молочные продукты',
        description: _productDescriptions['Масло сливочное'] ?? 'Описание отсутствует'
      ),
      Product(
        id: '4',
        name: 'Йогурт Активиа', 
        image: 'lib/images/activia.png', 
        price: 89.99, 
        category: 'Молочные продукты',
        description: _productDescriptions['Йогурт Активиа'] ?? 'Описание отсутствует'
      ),
      Product(
        id: '4',
        name: 'Кефир Домик в деревне', 
        image: 'lib/images/kefir.png', 
        price: 89.99, 
        category: 'Молочные продукты',
        description: _productDescriptions['Кефир Домик в деревне'] ?? 'Описание отсутствует'
      ),
      Product(
        id: '5',
        name: 'Хлеб Бородинский', 
        image: 'lib/images/hleb.png', 
        price: 89.99, 
        category: 'Хлебобулочные продукты',
        description: _productDescriptions['Хлеб Бородинский'] ?? 'Описание отсутствует'
      ),
      Product(
        id: '6',
        name: 'Батон нарезной', 
        image: 'lib/images/baton.png', 
        price: 89.99, 
        category: 'Хлебобулочные продукты',
        description: _productDescriptions['Батон нарезной'] ?? 'Описание отсутствует'
      ),
      Product(
        id: '7',
        name: 'Круассаны', 
        image: 'lib/images/kruassan.png', 
        price: 89.99, 
        category: 'Хлебобулочные продукты',
        description: _productDescriptions['Круассаны'] ?? 'Описание отсутствует'
      ),
      Product(
        id: '8',
        name: 'Колбаса Докторская', 
        image: 'lib/images/doctor.png', 
        price: 89.99, 
        category: 'Мясные продукты',
        description: _productDescriptions['Колбаса Докторская'] ?? 'Описание отсутствует'
      ),
      Product(
        id: '9',
        name: 'Курица охлажденная', 
        image: 'lib/images/cold_chicken.png', 
        price: 89.99, 
        category: 'Мясные продукты',
        description: _productDescriptions['Курица охлажденная'] ?? 'Описание отсутствует'
      ),
      Product(
        id: '10',
        name: 'Свинина для жарки', 
        image: 'lib/images/pig.png', 
        price: 89.99, 
        category: 'Мясные продукты',
        description: _productDescriptions['Свинина для жарки'] ?? 'Описание отсутствует'
      ),
      Product(
        id: '11',
        name: 'Яйца куриные', 
        image: 'lib/images/chicken_eggs.png', 
        price: 89.99, 
        category: 'Яйца',
        description: _productDescriptions['Яйца куриные'] ?? 'Описание отсутствует'
      ),
      Product(
        id: '12',
        name: 'Перепелиные яйца', 
        image: 'lib/images/eggs_other.png', 
        price: 89.99, 
        category: 'Яйца',
        description: _productDescriptions['Перепелиные яйца'] ?? 'Описание отсутствует'
      ),
      Product(
        id: '13',
        name: 'Помидоры свежие', 
        image: 'lib/images/tomato.png', 
        price: 89.99, 
        category: 'Овощи',
        description: _productDescriptions['Помидоры свежие'] ?? 'Описание отсутствует'
      ),
      Product(
        id: '14',
        name: 'Огурцы', 
        image: 'lib/images/cucumber.png', 
        price: 89.99, 
        category: 'Овощи',
        description: _productDescriptions['Огурцы'] ?? 'Описание отсутствует'
      ),
      Product(
        id: '15',
        name: 'Картофель', 
        image: 'lib/images/potato.png', 
        price: 89.99, 
        category: 'Овощи',
        description: _productDescriptions['Картофель'] ?? 'Описание отсутствует'
      ),
      Product(
        id: '16',
        name: 'Бананы', 
        image: 'lib/images/banana.png', 
        price: 89.99, 
        category: 'Фрукты',
        description: _productDescriptions['Бананы'] ?? 'Описание отсутствует'
      ),
      Product(
        id: '17',
        name: 'Яблоки Голден', 
        image: 'lib/images/golden_apple.png', 
        price: 89.99, 
        category: 'Фрукты',
        description: _productDescriptions['Яблоки Голден'] ?? 'Описание отсутствует'
      ),
    ];
  }
}