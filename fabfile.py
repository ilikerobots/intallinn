from fabric.api import *

env.use_ssh_config = True

pack_file_name = 'intallinn.tar.bz2'
unpack_dir = '/home/mike/tmp/intallinn'
env.hosts = ['intallinn.ee']
deploy_dir = '/opt/intallinn'

def pack():
    local("pub build")
    local("mkdir -p %s" % unpack_dir )
    local("rm -rf %s/*" % unpack_dir )
    local("cp -r build/web/  %s " % (unpack_dir))
    #local("cd %s/web; vulcanize --strip-comments  --exclude='pub/' --exclude='mdl/' --exclude='main.dart.js' --inline-css index.html > build.html; cp build.html index.html" % (unpack_dir))
    local("cd %s/web; vulcanize --strip-comments  --exclude='pub/'  --exclude='main.dart.js' --inline-css index.html > build.html; cp build.html index.html" % (unpack_dir))
    local("cd %s/web; tar -jc -f ../%s ." % (unpack_dir, pack_file_name))

    local("cp %s/%s ./build" % (unpack_dir, pack_file_name))
    local("rm -rf %s/*" % unpack_dir )


def deploy():
    run("mkdir -p %s" % unpack_dir )
    run("rm -rf %s/*" % unpack_dir )
    put("./build/%s" % (pack_file_name), "%s/" % (unpack_dir) )
    run("mv %s/%s %s/ " % (unpack_dir, pack_file_name, deploy_dir) )
    run("cd %s; tar -jx -f %s" % (deploy_dir,pack_file_name))
    run("rm %s/%s" % (deploy_dir, pack_file_name))
    run("cd %s; chmod -R a+r ." % (deploy_dir))
    run("rm -rf %s/*" % unpack_dir )


def clean():
    local("rm -rf %s" % unpack_dir )
    local("rm build/%s" % pack_file_name )
