#include <iostream>
#include <string>

using namespace std;

struct Book {
    char name[50];
    char author[50];
    float rating;
};

void display(Book book) {
    cout << "struct Book {" << endl;
    cout << book.name << endl;
    cout << book.author << endl;
    cout << book.rating << endl;
    cout << "}" << endl;
}


int main() {
    Book book = {"Book of unknown", "Benjamin S. Jakobsen", 4.0};

    display(book);

    return 0;
}