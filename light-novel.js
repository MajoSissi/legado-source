const fs = require('fs');
const path = require('path');

function merge() {
	const exclude = /ESJ轻小说\.me|rezero|缤纷幻想|番茄|再漫画|有度|bilibili专栏/i;
	const books = './books';
	const outFile = './source/light-novel.json';
	const result = [];
  const files = fs.readdirSync(books);
  let num = 0;
  files.forEach(file => {
      const filePath = path.join(books, file);
      const content = fs.readFileSync(filePath, 'utf-8');
      try{
      	const data = JSON.parse(content);
      	for(let ele of data){
      		const bookName = ele.bookSourceName;
      		if(exclude.test(bookName)) continue;
      		result.push(ele);
		    	console.log(`[${++num}] ${file} => ${bookName}`);
      	}
      }catch(error){
      	console.error(`[ERROR] ${file} => ${error.message}`);
      	return;
      }
  });
  fs.writeFileSync(outFile, JSON.stringify(result, null, 2), 'utf-8');
}

merge();
