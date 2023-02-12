#!/usr/bin/env python3

import re
import urllib.parse

import bunny1
from bunny1 import q, qp, expose, dont_expose
from cherrypy import HTTPRedirect

JIRA_TICKET_PATTERN = re.compile("^[A-Za-z]+-\d+$")
SOLRLUCENE_JIRA_TICKET_PATTERN = re.compile("^(SOLR|LUCENE)-\d+$", re.I)

class MyCommands(bunny1.Bunny1Commands):

    def box(self, arg):
        if arg:
            if arg in ("favorites", "favorite", "fav", "favs"):
                return "https://cloud.app.box.com/files/favorites"
            if arg in ("recents", "recent"):
                return "https://cloud.app.box.com/recents"
            if arg == "feed":
                return "https://cloud.app.box.com/feed"
            if arg == "notes":
                return "https://cloud.app.box.com/notes"
            if arg == "tasks":
                return "https://cloud.app.box.com/notifications/incomplete-tasks"
            if arg == "status":
                return "https://status.box.com/"
            if arg == "api":
                return "https://developer.box.com/v2.0/reference"
            if arg == "api search":
                return "https://developer.box.com/v2.0/reference#searching-for-content"
            if arg == "labs":
                return "https://cloud.app.box.com/box-labs"
            if arg == "personal":
                return "https://cloud.app.box.com/folder/51790408350"
            if arg in ("search", "search eng", "search engineering", "searcheng"):
                return "https://cloud.app.box.com/folder/1847582931"
            if arg == "console":
                return "https://cloud.app.box.com/developers/console/"
            if arg == "test":
                return "https://cloud.app.box.com/file/419639861014"
            if arg in ("testaccount", "testaccounts", "accounts"):
                return "https://cloud.app.box.com/notes/415764131306?s=ntkv8xlzpbf1k3v8ac7alilybnup6ymj"
            if arg == "wifi":
                return self._b1.do_command("boxwifi")

            return "https://cloud.app.box.com/folder/0/search?query=%s" % arg
        return "https://cloud.app.box.com"

    def boxforum(self, arg):
        """goes to the box community forum."""
        if arg:
            return "https://community.box.com/t5/forums/searchpage/tab/message?q=%s" % qp(arg)
        else:
            return "https://community.box.com/t5/All-Forums/ct-p/Forums"

    def boxiptest(self, arg):
        """goes to the box internal hostname and version page"""
        return "https://app.box.com/iptest.php"
    iptest = boxiptest

    def boxwifi(self, arg):
        return "https://cloud.app.box.com/v/boxguest"

    def jira(self, arg):
        if arg:
            if SOLRLUCENE_JIRA_TICKET_PATTERN.match(arg):
                return "https://issues.apache.org/jira/browse/%s" % qp(arg)
            elif JIRA_TICKET_PATTERN.match(arg):
                return "https://jira.inside-box.net/browse/%s" % qp(arg)
            else:
                return "https://jira.inside-box.net/issues/?jql=text ~ \"%s\"" % qp(arg)
        else:
            return "https://jira.inside-box.net/secure/RapidBoard.jspa?projectKey=SEARCH&rapidView=537"
    j = jira

    def confluence(self, arg):
        if arg:
            return "https://confluence.inside-box.net/dosearchsite.action?queryString=%s" % arg
        else:
            return "https://confluence.inside-box.net/pages/viewpage.action?pageId=65522035"
    c = confluence

    def jenkins(self, arg):
        if arg:
            if arg in ("search worker", "search-worker", "sw", "searchworker"):
                return "https://jenkins.pod.box.net/job/Skynet/job/search/job/search-worker"
            if arg in ("search query service", "search-query-service", "sws"):
                return "https://jenkins.pod.box.net/job/Skynet/job/search/job/search-query-service/"
            if arg == "sops":
                return "https://jenkins.pod.box.net/job/Skynet/job/search/job/sops/"
            if arg in ("user search worker", "user-search-worker", "user sw", "usersearchworker"):
                return "https://jenkins.pod.box.net/job/Skynet/job/search/job/search-worker/job/build-image-user-search-worker/"
            if arg in ("deploymentmanager", "dm", "cutrelease", "cut"):
                return "https://jenkins.pod.box.net/job/ScalaServices/job/Release/job/service-cut-release-candidate"
            return "https://jenkins.pod.box.net/job/ghe-friend/search/?q=%s" % arg
        return "https://jenkins.pod.box.net/"

    def gitosis(self, arg):
        if arg:
            if arg == "scm":
                return "https://dev-scm-ro.dev.box.net/cgit/scm/tree/"
            if arg == "infra":
                return "https://dev-scm-ro.dev.box.net/cgit/infra/tree/"
            if arg in ("deployment config", "deployment-config", "deploy config", "deploy-config", "dc"):
                return "https://dev-scm-ro.dev.box.net/cgit/deployment-config/tree/"
            if arg == "puppet":
                return "https://ops-scm.prod.box.net/cgit/puppet/tree/"
            if arg in ("hiera", "hieradata", "hiera data"):
                return "https://ops-scm.prod.box.net/cgit/puppet/tree/hieradata/common.json"
            if arg in ("appconf", "application conf", "application-conf"):
                return "https://ops-scm.prod.box.net/cgit/application_conf/tree/"
            if arg == "prod":
                return "https://ops-scm.prod.box.net/cgit/"
            if arg in ("services.conf", "services", "services conf", "conf_override"):
                return "https://ops-scm.prod.box.net/cgit/application_conf/tree/conf_override/services.conf"
            if arg in ("clusters.conf", "clusters", "clusters conf"):
                return "https://ops-scm.prod.box.net/cgit/application_conf/tree/search-worker/clusters.conf"
            if arg in ("solr", "solr confs", "solrconfig"):
                return "https://dev-scm-ro.dev.box.net/cgit/infra/tree/scala/services/sops/solr_confs/solr7_base"
        return "https://dev-scm-ro.dev.box.net/cgit"
    git = gitosis
    cgit = gitosis

    def appconf(self, arg):
        if arg:
            if arg in ("services.conf", "services", "services conf", "conf_override"):
                return "https://ops-scm.prod.box.net/cgit/application_conf/tree/conf_override/services.conf"
            if arg in ("clusters.conf", "clusters", "clusters conf"):
                return "https://ops-scm.prod.box.net/cgit/application_conf/tree/search-worker/clusters.conf"
        return "https://ops-scm.prod.box.net/cgit/application_conf/tree/"

    def puppet(self, arg):
        if arg:
            if arg in ("hiera", "hieradata", "hiera data"):
                return "https://ops-scm.prod.box.net/cgit/puppet/tree/hieradata/common.json"
        return "https://ops-scm.prod.box.net/cgit/puppet/tree/"

    def devappconf(self, arg):
        if arg:
            if arg in ("services.conf", "services", "services conf", "conf_override"):
                return "https://git.dev.box.net/Box/appconf/blob/dev/conf_override/services.conf"
            if arg in ("clusters.conf", "clusters", "clusters conf"):
                return "https://git.dev.box.net/Box/appconf/blob/dev/search-worker/clusters.conf"
        return "https://git.dev.box.net/Box/appconf"
    appconfdev = devappconf

    def arta(self, arg):
        if arg:
            if arg == "dev":
                return "https://dlt-es-elb.dev.box.net:8000/app/kibana#/discover"
            if arg in ("schema", "schemas", "schemarepo", "schema repo"):
                return "https://git.dev.box.net/monitoring/analytics-schemas"
        return "https://arta-es-elb.vsv1.box.net:8000/app/kibana#/discover"

    def artadev(self, arg):
        return "https://dlt-es-elb.dev.box.net:8000/app/kibana#/discover"
    devarta = artadev

    def vault(self, arg):
        return "https://vault.ad.whirl.net"

    def ldap(self, arg):
        return "https://ldap-self-service.inside-box.net/"

    def cloudscope(self, arg):
        return "https://cloudscope.prod.box.net"
    devvm = cloudscope

    def deploymentmanager(self, arg):
        if arg:
            if arg == "ve":
                return "https://dm.ve.box.net/#/services"
            if arg == "vsv1":
                return "https://dm.vsv1.box.net/#/services"
            if arg == "lv7":
                return "https://dm.lv7.box.net/#/services"
            if arg in ("reno", "rno"):
                return "https://dm.us-rno-a.dc001.prod.box.net/#/services"
            if arg == "dev":
                return "https://dm.dev.box.net/#/services"
        return "https://dm.ve.box.net/#/services"

    def kubeapplier(self, arg):
        return "http://applier.octoproxy.dsv31.boxdc.net/"

    def servicecat(self, arg):
        return "https://servicecat.prod.box.net:8301/services"
    cat = servicecat

    def scala(self, arg):
        if arg:
            if arg == "tour":
                return "https://docs.scala-lang.org/tour/tour-of-scala.html"
            if arg == "api":
                return "https://www.scala-lang.org/api/2.10.4/index.html#package"
            if arg == "specs":
                return "https://github.com/etorreborre/specs2/tree/3e83251e82264e2e74781775e2b5b4926854d2d0"

    def kubernetes(self, arg):
        if arg:
            if arg in ("api", "reference"):
                return "https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.10"
            if arg in ("deployment", "deployments", "deploy"):
                return "https://kubernetes.io/docs/concepts/workloads/controllers/deployment"
            if arg in ("lifecycle", "rollingrestart", "rolling", "restart", "roll"):
                return "https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle"
            return "https://kubernetes.io/docs/home"
    k8s=kubernetes
    kube=kubernetes

    def wavefront(self, arg):
        if arg:
            if arg == "arta":
                return "https://box.wavefront.com/dashboard/ArtA_Resources"
            if arg == "mqs":
                return "https://box.wavefront.com/dashboard/MQS"
            if arg == "query":
                return "https://box.wavefront.com/dashboard/SearchQueryOutageDashboard"
            if arg == "alan":
                return "https://box.wavefront.com/dashboard/alan-search-query-dashboard"
            if arg == "search":
                return "https://box.wavefront.com/dashboard/search"
            if arg == "build" or arg == "build cluster":
                return "https://box.wavefront.com/dashboard/search-build-cluster"
            if arg == "stats" or arg == "search stats":
                return "https://box.wavefront.com/dashboard/search-stats"
            if arg == "search worker" or arg == "search workers":
                return "https://box.wavefront.com/dashboard/search-workers"
            return "https://box.wavefront.com/dashboards?search={\"searchTerms\":[{\"type\":\"freetext\",\"value\":\"%s\"}]}" % qp(arg)
        else:
            return "https://box.wavefront.com/dashboard/search"
    wf = wavefront

    def pagerduty(self, args):
        return "https://boxcom.pagerduty.com/incidents?assignedToUser=POMAXB4"
    pd = pagerduty

    def zendesk(self, args):
        return "https://box.zendesk.com/agent/dashboard"

    def boxgithub(self, arg):
        if arg:
            if arg in ("arta", "schema", "schemarepo", "schema repo"):
                return "https://git.dev.box.net/monitoring/analytics-schemas"
            if arg in ("appconf", "dev appconf", "devappconf"):
                return "https://git.dev.box.net/Box/appconf"
            if arg == "butter":
                return "https://git.dev.box.net/Butter-ai"
            if arg == "search":
                return "https://git.dev.box.net/SearchDev"
            if arg == "gist":
                return "https://git.dev.box.net/gist/awalz"
            return "https://git.dev.box.net/search?q=%s" % arg
        else:
            return "https://git.dev.box.net/"
    ghe = boxgithub

    def gist(self, arg):
        if arg:
            if arg == "new":
                return "https://git.dev.box.net/gist"
            if arg == "mine":
                return "https://git.dev.box.net/gist/awalz"
            if arg in ("all", "discover"):
                return "https://git.dev.box.net/gist/discover"
            return "https://git.dev.box.net/gist/awalz"
        return "https://git.dev.box.net/gist/awalz"

    def stackoverflow(self, arg):
        if arg:
            if arg in ("questions", "question", "q"):
                return "https://stackoverflow.com/c/enterprise-at-box/questions"
            if arg in ("tags", "tag", "t"):
                return "https://stackoverflow.com/c/enterprise-at-box/tags"
            if arg in ("users", "user"):
                return "https://stackoverflow.com/c/enterprise-at-box/users"
            if arg == "search":
                return "https://stackoverflow.com/c/enterprise-at-box/questions/tagged/90"
            if arg == "solr":
                return "https://stackoverflow.com/c/enterprise-at-box/questions/tagged/91"
            if arg in ("token", "tokenization", "tokens", "tokenize"):
                return "https://stackoverflow.com/c/enterprise-at-box/questions/tagged/92"
            if arg == "me":
                return "https://stackoverflow.com/c/enterprise-at-box/users/192/"
            return "https://stackoverflow.com/c/enterprise-at-box/search?tab=relevance&mixed=0&q=%s" % arg
        else:
            return "https://stackoverflow.com/c/enterprise-at-box"
    so = stackoverflow
    stack = stackoverflow

    def mail(self, arg):
        if arg:
            return "https://mail.google.com/mail/u/0/#search/%s" % arg
        return "https://mail.google.com/mail/u/0/#inbox"

    def calendar(self, arg):
        if arg:
            if arg == "day":
                return "https://calendar.google.com/calendar/r/day"
            if arg == "week":
                return "https://calendar.google.com/calendar/r/week"
            if arg == "month":
                return "https://calendar.google.com/calendar/r/month"
            if arg == "year":
                return "https://calendar.google.com/calendar/r/year"
            return "https://calendar.google.com/calendar/r/search?q=%s" % arg
        return "https://calendar.google.com/calendar/r/week"
    cal = calendar

    def okta(self, arg):
        return "https://box.okta.com/app/UserHome"

    def yt(self, arg):
        """Searches YouTube or goes to it"""
        if arg:
            return "http://www.youtube.com/results?search_query=%s&search_type=&aq=-1&oq=" % qp(arg)
        else:
            return "http://www.youtube.com/"

    def solr(self, arg):
        if arg:
            if arg in ("mail", "mailing", "mailing list"):
                return "http://mail-archives.apache.org/mod_mbox/lucene-solr-user/"
            elif arg == "jira":
                return "https://issues.apache.org/jira/projects/SOLR/issues"
            elif arg == "wiki":
                return "https://cwiki.apache.org/confluence/display/solr"
            elif arg in ("git", "github"):
                return "https://github.com/apache/lucene-solr/tree/master/solr"
            else:
                return "https://lucene.apache.org/solr/guide/7_7/index.html"
        return "https://lucene.apache.org/solr/guide/7_7/index.html"

    def lucene(self, arg):
        if arg:
            if arg in ("mail", "mailing", "mailing list"):
                return "http://mail-archives.apache.org/mod_mbox/lucene-java-user/"
            elif arg == "jira":
                return "https://issues.apache.org/jira/projects/LUCENE/issues"
            elif arg == "wiki":
                return "https://cwiki.apache.org/confluence/display/lucene"
            elif arg in ("git", "github"):
                return "https://github.com/apache/lucene-solr/tree/master/lucene"
            else:
                return "http://lucene.apache.org/core/"
        return "http://lucene.apache.org/core/"

    def solrgithub(self, arg):
        if arg:
            if arg in ("7", "7.7", "7.7.0"):
                return "https://github.com/apache/lucene-solr/tree/8c831daf4eb41153c25ddb152501ab5bae3ea3d5"
            else:
                return "https://github.com/apache/lucene-solr"
        return "https://github.com/apache/lucene-solr"
    solrgit = solrgithub
    sgit = solrgithub
    sgithub = solrgithub

    def lucenegithub(self, arg):
        if arg:
            if arg in ("7", "7.7", "7.7.0"):
                return "https://github.com/apache/lucene-solr/tree/8c831daf4eb41153c25ddb152501ab5bae3ea3d5"
            elif arg == "site":
                return "https://github.com/apache/lucene-site"
            else:
                return "https://github.com/apache/lucene-solr"
        return "https://github.com/apache/lucene-solr"
    lucenegit = lucenegithub
    lgit = lucenegithub
    lgithub = lucenegithub

    def gerrit(self, arg):
        if arg:
            if arg == "mine":
                return "https://scm.dev.box.net/#/q/status:open+owner:self,n,z"
            if arg == "prod":
                return "https://gerrit.prod.box.net/#/"
            return "https://scm.dev.box.net/#/q/%s" % q(arg)
        return "https://scm.dev.box.net/#/"
    devgerrit = gerrit
    gerritdev = gerrit

    def opsgerrit(self, arg):
        if arg:
            if arg == "mine":
                return "https://gerrit.prod.box.net/#/q/status:open+owner:self,n,z"
            return "https://gerrit.prod.box.net/#/q/%s" % q(arg)
        return "https://gerrit.prod.box.net/#/"
    prodgerrit = opsgerrit
    gerritprod = opsgerrit

    def qubole(self, arg):
        return "https://box-prod-1.qubole.com/v2/analyze"
    aic = qubole
    hive = qubole

    def splunk(self, args):
        return "https://splunk.prod.box.net:8000"

    def zephyr(self, arg):
        return "http://zephyr.prod.box.net:8080/#"

    def okr(self, arg):
        if arg:
            if arg.lower() in ("q4fy19"):
                return "https://docs.google.com/spreadsheets/d/19eCo66qO14r5vAyV0suttXAxQHN9ch-d4jiCnqOuklk/edit#gid=1495014630"
            if arg.lower() in ("q1", "q1fy20"):
                return "https://docs.google.com/spreadsheets/d/180Qwu3o6-wD72VrsYuyh4faLzXB31jPsOlVlB_zfDAc/edit#gid=1495014630"
            if arg.lower() in ("q2", "q2fy20"):
                return "https://docs.google.com/spreadsheets/d/1LzpGyyz52C7g9RmJzc9JNh1mocQz77XsCAVatoLphP4/edit#gid=1495014630"
            if arg.lower() in ("q3", "q3fy20"):
                return "https://docs.google.com/spreadsheets/d/1-hLbaBAe7P2l5cbpuZ8q12gUKslATDqf_9SUbV3hFxE/edit#gid=1495014630"
            if arg.lower() in ("q4", "q4fy20"):
                return "https://docs.google.com/spreadsheets/d/1gD9GEqR64JlQd0jv8I-huusUYeQftrVFkFExs5dwn9o/edit#gid=1495014630"
        return "https://docs.google.com/spreadsheets/d/1gD9GEqR64JlQd0jv8I-huusUYeQftrVFkFExs5dwn9o/edit#gid=1495014630"

    def hbase(self, arg):
        if arg:
            if arg == "vsv1":
                return "http://sfi-name6003.vsv1.box.net:50030/jobtracker.jsp"
            if arg == "ve":
                return "http://sfi-name1003.ve.box.net:50030/jobtracker.jsp"
            if arg == "lv7":
                return "http://sfi-name3003.lv7.box.net:50030/jobtracker.jsp"
            if arg in ("lv7d", "sfid"):
                return "http://sfi-name3010.lv7.box.net:50030/jobtracker.jsp"
            if arg == "dev":
                return "http://dev-alf-name03.dev.box.net:50030/jobtracker.jsp"
            if arg == "staging":
                return "http://staging-ss-hbase-name12.dsv31.boxdc.net:50030/jobtracker.jsp"
        return "http://sfi-name6003.vsv1.box.net:50030/jobtracker.jsp"
    hadoop = hbase
    job = hbase
    jobtracker = hbase

    def sensu(self, arg):
        if arg:
            if arg == "checks":
                return "https://sensu.prod.box.net:3000/#/checks"
            if arg == "clients":
                return "https://sensu.prod.box.net:3000/#/clients"
            if arg == "events":
                return "https://sensu.prod.box.net:3000/#/events"
        return "https://sensu.prod.box.net:3000/#/events"

    def time(self, arg):
        """shows the current time in US time zones"""
        return "http://tycho.usno.navy.mil/cgi-bin/timer.pl"

    # an example of showing content instead of redirecting and also
    # using content from the filesystem
    def readme(self, arg):
        """shows the contents of the README file for this software"""
        raise bunny1.PRE(bunny1.bunny1_file("README"))

    def stock(self, arg):
        if arg:
            return "https://www.google.com/search?tbm=fin&q=%s" % arg
        return "https://www.google.com/finance"

    def images(self, arg):
        if arg:
            return "https://www.google.com/search?tbm=isch&source=lnms&q=%s" % arg
        return "https://www.google.com/imghp"
    image = images
    img = images

    def news(self, arg):
        if arg:
            return "https://www.google.com/search?tbm=nws&source=lnms&q=%s" % arg
        return "https://news.google.com"

    def amazon(self, arg):
        if arg:
            return "https://www.amazon.com/s?k=%s" % arg
        return "https://www.amazon.com"
    am = amazon
    amz = amazon

    # fallback is special method that is called if a command isn't found
    # by default, bunny1 falls back to yubnub.org which has a pretty good
    # database of commands that you would want to use, but you can configure
    # it to point anywhere you'd like.  ex. you could run a personal instance
    # of bunny1 that falls back to a company-wide instance of bunny1 which
    # falls back to yubnub or some other global redirector.  yubnub similarly
    # falls back to doing a google search, which is often what a user wants.

    @dont_expose
    def fallback(self, raw, *a, **k):

        # this code makes it so that if you put a command in angle brackets
        # (so it looks like an HTML tag), then the command will get executed.
        # doing something like this is useful when there is a server on your
        # LAN with the same name as a command that you want to use without
        # any arguments.  ex. at facebook, there is an 'svn' command and
        # the svn(.facebook.com) server, so if you type 'svn' into the
        # location bar of a browser, it goes to the server first even though
        # that's not usually what you want.  this provides a workaround for
        # that problem.
        if raw.startswith("<") and raw.endswith(">"):
            return self._b1.do_command(raw[1:-1])

        if JIRA_TICKET_PATTERN.match(raw):
            return self._b1.do_command("jira " + raw)

        # meta-fallback
        # return bunny1.Bunny1Commands.fallback(self, raw, *a, **k)

        raise HTTPRedirect("http://www.google.com/search?q=" + q(raw))

def rewrite_tld(url, new_tld):
    """changes the last thing after the dot in the netloc in a URL"""
    (scheme, netloc, path, query, fragment) = urllib.parse.urlsplit(url)
    domain = netloc.split(".")

    # this is just an example so we naievely assume the TLD doesn't
    # include any dots (so this breaks if you try to rewrite .co.jp
    # URLs for example)...
    domain[-1] = new_tld
    new_domain = ".".join(domain)
    new_url = urllib.parse.urlunsplit((scheme, new_domain, path, query, fragment))
    print(new_url)
    return new_url

def tld_rewriter(new_tld):
    """returns a function that rewrites the TLD of a URL to be new_tld"""
    return expose(lambda url: rewrite_tld(url, new_tld))

class MyDecorators(bunny1.Bunny1Decorators):
    """decorators that show switching between TLDs"""

    # we don't really need to hardcode these since they should get handled
    # by the default case below, but we'll include them just as examples.
    # For instance. Type "@org https://box.com" to be redirected to
    # "https://box.org"
    com = tld_rewriter("com")
    net = tld_rewriter("net")
    org = tld_rewriter("org")
    edu = tld_rewriter("edu")

    # make it so that you can do @co.uk -- the default decorator rewrites the TLD
    def __getattr__(self, attr):
        return tld_rewriter(attr)

    @expose
    def identity(self, url):
        """a no-op decorator"""
        return url

class MyBunny(bunny1.Bunny1):
    def __init__(self):
        bunny1.Bunny1.__init__(self, MyCommands(), MyDecorators())

if __name__ == "__main__":
    print("hello world")
    bunny1.main(MyBunny())


