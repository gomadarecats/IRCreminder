const net = require('http');
const exec = require('child_process').exec;
const port = 8667;
const dir = '/remind'

exec('/etc/init.d/atd start');
exec('/etc/init.d/cron start');
exec('crontab /cron.txt');

let srv = net.createServer((req, res) => {
  if (req.method === 'GET') {
    exec('bash $dir/remlist.sh', {env: {'dir': dir}});
  } else if (req.method === 'POST') {
    req.on('data', (body) => {
      if (JSON.parse(body.toString()).time == null || JSON.parse(body.toString()).param == null) {
        console.log('invalid parameter');
      } else {
        exec('bash $dir/remind.sh "$time" "$param"', {env: {'dir': dir, 'time': JSON.parse(body.toString()).time, 'param': (new TextDecoder).decode(new Uint8Array(JSON.parse(body.toString()).param.split(' ')))}});
      }
    });
  } else if (req.method === 'DELETE') {
    req.on('data', (body) => {
      if (JSON.parse(body.toString()).param == null) {
        console.log('invalid parameter');
      } else {
        exec('at -d "$param" && bash $dir/irc.sh "job $param deleted!"', {env: {'dir': dir, 'param': JSON.parse(body.toString()).param}});
      };
    });
  } else {
    console.log('FORBIDDEN REQUIEST');
  };

  res.writeHead(200, {
  });
  res.end();
});

srv.listen(port);
