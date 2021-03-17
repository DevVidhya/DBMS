let mysql = require('mysql');

let con = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'Semester@5',
    database: 'ebanking'
});

con.connect(function(err,res){
    if(err) throw err;
    console.log("Connected!");

    // con.query(createTablesQuery[0], function(err, res) {
    //     if(err) throw err;
    //     con.query(createTablesQuery[1], function(err, res) {
    //         if(err) throw err;
    //     });
    // });

    console.log(`Select options : 
    1) create Account
    2) credit
    3) debit
    4) delete account
    5) show mini statement
    6) transfer
    `)

    let input = process.stdin;
    input.setEncoding('utf-8');
    input.on('data', (data) => {
        data = data.split(' ');
        if(data[0] == 1) {
            createAccount(data[1], con);
        }
        if(data[0] == 2) {
            credit(data[1], data[2], con);
        }
        if(data[0] == 3) {
            debit(data[1], data[2], con);
        }
        if(data[0] == 5) {
            ministatement(data[1], con);
        }
        if(data[0] == 4) {
            deleteUser(data[1], con);
        }
        if(data[0] == 6)
            transfer(data[1], data[2], data[3]);
    });


});

function createAccount(Name, con) {
    con.query(`insert into Customers (name, balance) values ('${Name}', 0)`, function(err, res) {
        if(err) throw err;
    });
}

function credit(Aid, amount) {
    con.query(`update Customers set balance=balance+${amount} where Aid=${Aid}`, (err) => {
        if(err) throw err;
    });
    con.query(`insert into transactions (amount, dateOfTransaction, type, Aid) values (${amount}, curdate(), 'credit', ${Aid})`, (err) => {
        if(err) throw err;
    });
}

function debit(Aid, amount) {
    con.query(`update Customers set balance=balance-${amount} where Aid=${Aid}`, (err) => {
        if(err) throw err;
    });
    con.query(`insert into transactions (amount, dateOfTransaction, type, Aid) values (${amount}, curdate(), 'debit', ${Aid})`, (err) => {
        if(err) throw err;
    });
}

function ministatement(Aid) {
    con.query(`select * from transactions where Aid=${Aid}`, (err, res) => {
        if(err) throw err;
        console.log(res);
    });
};

function deleteUser(Aid) {
    con.query(`delete from Customers where Aid=${Aid}`, (err, res) => {
        if(err) throw err;
    });
}

function transfer(from, to, amt) {
    credit(to, amt);
    debit(from, amt);
}

let createTablesQuery = [
    `create table Customers(
        Aid int not null auto_increment primary key,
        name varchar(255),
        balance int
    )`,
    `create table transactions(
        Tid int not null auto_increment primary key,
        amount int,
        dateOfTransaction Date,
        type varchar(255),
        Aid int not null,
        foreign key (Aid) references Customers(Aid)
    )`
];