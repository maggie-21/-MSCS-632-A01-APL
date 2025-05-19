fn main() {
    let data = Box::new(vec![1, 2, 3, 4, 5]); // heap allocation
    print_data(&data); // Borrowed reference
    // data is automatically freed here when it goes out of scope
}

fn print_data(data: &Vec<i32>) {
    println!("Data: {:?}", data);
}
