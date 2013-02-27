
/*
 * GET home page.
 */

exports.index = function(req, res){
  res.render('index', { title: 'www.salionov.ru' });
 };

exports.workplaces = function(req, res) {
    res.render('workplaces', {
        title: "My workplaces",
        bread: [
            {text: "Main", href:"/"},
            {text: "My workplaces"},
        ],
        jobs: [
            {name: "VVSU", descr: "PHP, JS, VB, C#, MSSQL", time: "2008-2012"}, 
            {name: "KamaGames", descr: "JAVA, PostgreSQL", time: "2012-2013"},
            {name: "Drom.ru", descr: "PHP, NodeJS, MySQL, Mongo", time: "2013-..."}
        ]
    });
};
