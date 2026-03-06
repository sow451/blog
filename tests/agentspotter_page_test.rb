require "minitest/autorun"
require "open3"
require "pathname"
require "yaml"

class AgentspotterPageTest < Minitest::Test
  ROOT = Pathname.new(__dir__).join("..").expand_path
  PAGE_FILE = ROOT.join("_pages/agentspotter.md")
  CONTEXT_FILE = ROOT.join("_pages/agentspotter-context.md")
  LLMS_FILE = ROOT.join("llms.txt")
  AI_RECIPE_FILE = ROOT.join("ai/recipe.md")
  NAV_FILE = ROOT.join("_layouts/default.html")
  PROJECT_FILE = ROOT.join("_projects/2026-agentspotter-public-feed.md")
  GENERATED_FILE = ROOT.join("_site/agentspotter/index.html")
  GENERATED_LLMS_FILE = ROOT.join("_site/llms.txt")
  GENERATED_AI_RECIPE_FILE = ROOT.join("_site/ai/recipe.md")

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
      "Agentspotter tracks public AI crawler and agent activity through a small public experiment.",
      'Data below. Note that a hi from "agent" only means there was follow-through, not a true guarantee of autonomy.',
      '<a href="/agentspotter/context/">Agentspotter Context</a>',
      '<div class="agentspotter-shell">',
      'id="agentspotter-status"',
      "Global Counters",
      "agentspotter-card-grid-eight",
      "Lazy hi (GET /hi)",
      "V serious hi (POST /hi + token)",
      "Event Feed",
      'id="agentspotter-counters"',
      'id="agentspotter-filter-type"',
      'id="agentspotter-filter-page-size"',
      'id="agentspotter-filter-order"',
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
      %r{API_URL\s*=\s*".*/events/public\?type=all&source=all&hide_likely_crawlers=true&limit=50";},
      body
    )
    assert_includes body, 'setStatus("", false);'
    assert_includes body, 'setStatus("Could not load the public feed right now. Please try again shortly.", true);'
    assert_includes body, "fetch(API_URL"
    assert_includes body, "renderCards(state.counters);"
    assert_includes body, "[typeFilterEl, pageSizeEl, orderEl].forEach"
    assert_includes body, "Loaded \" + numberFormat.format(events.length) + \" matching events."
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
      "/events/public?type=all&source=all&hide_likely_crawlers=true&limit=50",
      "Global Counters",
      "Event Feed",
      "agentspotter-table-body"
    ]

    core_markers.each do |marker|
      assert_includes generated_html, marker, "Expected generated HTML to include #{marker.inspect}"
    end
  end

  def test_agentspotter_context_page_exists_with_permalink
    assert CONTEXT_FILE.file?, "Expected #{CONTEXT_FILE} to exist"

    front_matter, body = parse_markdown_with_front_matter(CONTEXT_FILE)

    assert_equal "page", front_matter["layout"]
    assert_equal "Agentspotter Context", front_matter["title"]
    assert_equal "/agentspotter/context/", front_matter["permalink"]
    assert_includes body, "# agent-spotter: context"
    assert_includes body, "## Table of Contents"
    assert_includes body, "### Purpose"
    assert_includes body, "### Flow"
    assert_includes body, "### Contact"
    refute_includes body, "README Context"
  end

  def test_root_discovery_files_exist_and_include_canonical_links
    assert LLMS_FILE.file?, "Expected #{LLMS_FILE} to exist"
    assert AI_RECIPE_FILE.file?, "Expected #{AI_RECIPE_FILE} to exist"

    llms_body = LLMS_FILE.read
    ai_recipe_body = AI_RECIPE_FILE.read

    assert_includes llms_body, "https://sowrao.com/ai/recipe.md"
    assert_includes llms_body, "https://agentspotter-backend-production.up.railway.app/ai/recipe.md"
    assert_includes llms_body, "https://agentspotter-backend-production.up.railway.app/banana-muffins.md"
    assert_includes llms_body, "https://agentspotter-backend-production.up.railway.app/agent.txt"
    assert_includes llms_body, "https://sowrao.com/agentspotter/context/"

    assert_includes ai_recipe_body, "https://agentspotter-backend-production.up.railway.app/ai/recipe.md"
    assert_includes ai_recipe_body, "https://agentspotter-backend-production.up.railway.app/banana-muffins.md"
    assert_includes ai_recipe_body, "https://agentspotter-backend-production.up.railway.app/agent.txt"
    assert_includes ai_recipe_body, "https://agentspotter-backend-production.up.railway.app/hi"
  end

  def test_generated_root_discovery_files_are_published
    assert self.class.build_status&.success?, build_failure_message
    assert GENERATED_LLMS_FILE.file?, "Expected generated file #{GENERATED_LLMS_FILE} to exist"
    assert GENERATED_AI_RECIPE_FILE.file?, "Expected generated file #{GENERATED_AI_RECIPE_FILE} to exist"

    generated_llms = GENERATED_LLMS_FILE.read
    generated_ai_recipe = GENERATED_AI_RECIPE_FILE.read

    assert_includes generated_llms, "https://sowrao.com/ai/recipe.md"
    assert_includes generated_llms, "https://agentspotter-backend-production.up.railway.app/agent.txt"
    assert_includes generated_ai_recipe, "https://agentspotter-backend-production.up.railway.app/agent.txt"
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
