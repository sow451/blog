require "minitest/autorun"
require "open3"
require "pathname"
require "yaml"

class AgentspotterPageTest < Minitest::Test
  ROOT = Pathname.new(__dir__).join("..").expand_path
  PAGE_FILE = ROOT.join("_pages/agentspotter.md")
  NAV_FILE = ROOT.join("_layouts/default.html")
  PROJECT_FILE = ROOT.join("_projects/2026-agentspotter-public-feed.md")
  GENERATED_FILE = ROOT.join("_site/agentspotter/index.html")

  class << self
    attr_reader :build_status, :build_stdout, :build_stderr
  end

  def setup
    self.class.run_jekyll_build_once!
  end

  def self.run_jekyll_build_once!
    return if defined?(@build_ran) && @build_ran

    bundle_command = resolve_bundle_command
    @build_stdout, @build_stderr, @build_status = Open3.capture3(
      bundle_command, "exec", "jekyll", "build",
      chdir: ROOT.to_s
    )
    @build_ran = true
  end

  def self.resolve_bundle_command
    candidates = [
      ENV["BUNDLE_BIN"],
      "/opt/homebrew/opt/ruby@3.2/bin/bundle",
      "/opt/homebrew/opt/ruby/bin/bundle",
      "bundle"
    ].compact

    candidates.find do |candidate|
      if candidate.include?("/")
        File.executable?(candidate)
      else
        system("which", candidate, out: File::NULL, err: File::NULL)
      end
    end || "bundle"
  end

  def test_agentspotter_page_front_matter_and_required_blocks
    assert PAGE_FILE.file?, "Expected #{PAGE_FILE} to exist"

    front_matter, body = parse_markdown_with_front_matter(PAGE_FILE)

    assert_equal "page", front_matter["layout"]
    assert_equal "Agentspotter", front_matter["title"]
    assert_equal "/agentspotter/", front_matter["permalink"]

    required_blocks = [
      "Agentspotter tracks public AI crawler and agent activity.",
      "<h2>Quick Context</h2>",
      "Signal Glossary",
      "context.md on GitHub",
      '<div class="agentspotter-shell">',
      'id="agentspotter-status"',
      'id="agentspotter-counters"',
      'id="agentspotter-table-wrap"',
      '<tbody id="agentspotter-table-body"></tbody>'
    ]

    required_blocks.each do |snippet|
      assert_includes body, snippet, "Expected agentspotter page to include #{snippet.inspect}"
    end
  end

  def test_agentspotter_page_js_contract_for_public_events_and_states
    _front_matter, body = parse_markdown_with_front_matter(PAGE_FILE)

    assert_match(
      %r{API_URL\s*=\s*".*/events/public\?type=all&source=all&hide_likely_crawlers=true&limit=25";},
      body
    )
    assert_includes body, 'setStatus("Loading latest public events...", false);'
    assert_includes body, 'setStatus("Could not load the public feed right now. Please try again shortly.", true);'
    assert_includes body, "fetch(API_URL"
    assert_includes body, 'pickFirst(event, ["source_kind", "source", "source_type", "channel", "origin"])'
    assert_includes body, 'pickFirst(event, ["ts", "occurred_at", "occurredAt", "timestamp", "created_at", "createdAt", "event_time", "time"])'
  end

  def test_nav_contains_agentspotter_link
    assert NAV_FILE.file?, "Expected #{NAV_FILE} to exist"
    nav_html = NAV_FILE.read

    assert_match(
      %r{<a href="\{\{\s*site\.baseurl\s*\}\}/agentspotter">Agentspotter</a>},
      nav_html
    )
  end

  def test_project_entry_exists_and_links_to_agentspotter
    assert PROJECT_FILE.file?, "Expected #{PROJECT_FILE} to exist"

    front_matter, body = parse_markdown_with_front_matter(PROJECT_FILE)

    assert_match(/Agentspotter/i, front_matter["title"].to_s)
    assert_equal "/agentspotter/", front_matter["preview"]
    assert_includes body, "[Agentspotter Public Feed](/agentspotter/)"
  end

  def test_generated_agentspotter_page_exists_and_has_core_markers
    assert self.class.build_status&.success?, build_failure_message
    assert GENERATED_FILE.file?, "Expected generated file #{GENERATED_FILE} to exist"

    generated_html = GENERATED_FILE.read
    core_markers = [
      "agentspotter-shell",
      "agentspotter-status",
      "Loading latest public events...",
      "/events/public?type=all&source=all&hide_likely_crawlers=true&limit=25",
      "agentspotter-table-body"
    ]

    core_markers.each do |marker|
      assert_includes generated_html, marker, "Expected generated HTML to include #{marker.inspect}"
    end
  end

  private

  def parse_markdown_with_front_matter(pathname)
    content = pathname.read
    match = content.match(/\A---\s*\n(.*?)\n---\s*\n(.*)\z/m)
    refute_nil match, "Expected #{pathname} to include YAML front matter"

    front_matter = YAML.safe_load(match[1], permitted_classes: [], aliases: false) || {}
    [front_matter, match[2]]
  end

  def build_failure_message
    [
      "Expected `bundle exec jekyll build` to succeed",
      "stdout:",
      self.class.build_stdout.to_s.strip,
      "stderr:",
      self.class.build_stderr.to_s.strip
    ].join("\n")
  end
end
