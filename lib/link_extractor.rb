class LinkExtractor
  class << self
    #NOTE: Stole from text_helper
    AUTO_LINK_RED = %r{
                    (                          # leading text
                      <\w+.*?>|                # leading HTML tag, or
                      [^=!:'"/]|               # leading punctuation, or
                      ^                        # beginning of line
                    )
                    (
                      (?:https?://)|           # protocol spec, or
                      (?:www\.)                # www.*
                    )
                    (
                      [-\w]+                   # subdomain or domain
                      (?:\.[-\w]+)*            # remaining subdomains or domain
                      (?::\d+)?                # port
                      (?:/(?:(?:[~\w\+@%=\(\)-]|(?:[,.;:][^\s$]))+)?)* # path
                      (?:\?[\w\+@%&=.;-]+)?     # query string
                      (?:\#[\w\-]*)?           # trailing anchor
                    )
                    ([[:punct:]]|<|$|)       # trailing text
                   }x unless const_defined?(:AUTO_LINK_RED)
    
    def extract(text)
      links = []
      text.scan(AUTO_LINK_RED).each do |link|
        links << (link[1] + link[2])
      end
      links
    end
  end
end