package com.example.demo.bean;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;


import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * PageTreeInfo
 */

@JsonIgnoreProperties//(ignoreUnknown = true)
public class PageTreeInfo implements Serializable {

    private static final long serialVersionUID = -8520773347521909293L;

    @JsonProperty("\"url\"")
    private String url;

    @JsonProperty("\"title\"")
    private String title;

    public String getThirdOne() {
        return thirdOne;
    }

    public void setThirdOne(String thirdOne) {
        this.thirdOne = thirdOne;
    }

    @JsonProperty("\"thirdOne\"")
    private String thirdOne;


    @JsonProperty("\"nodes\"")
    private List<PageTreeInfo> nodes;

    /**
     * get model with url with default invalid
     *
     */
    public PageTreeInfo() {
    }


    /**
     * page Url
     *
     * @return url
     **/

    public String getUrl() {
        return url;
    }

    public void setUrl(final String url) {
        this.url = url;
    }

    public PageTreeInfo title(final String title) {
        this.title = title;
        return this;
    }

    /**
     * Page title
     *
     * @return title
     **/

    public String getTitle() {
        return title;
    }

    public void setTitle(final String title) {
        this.title = title;
    }


    public PageTreeInfo nodes(final List<PageTreeInfo> nodes) {
        this.nodes = nodes;
        return this;
    }

    public PageTreeInfo addNodesItem(final PageTreeInfo nodesItem) {
        if (nodes == null) {
            nodes = new ArrayList<>();
        }
        if (nodesItem != null) {
            nodes.add(nodesItem);
        }
        return this;
    }

    /**
     * Get nodes
     *
     * @return nodes
     **/

    public List<PageTreeInfo> getNodes() {
        return nodes;
    }

    public void setNodes(final List<PageTreeInfo> nodes) {
        this.nodes = nodes;
    }

    @Override
    public boolean equals(final java.lang.Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        final PageTreeInfo pageTreeInfo = (PageTreeInfo) o;
        return Objects.equals(url, pageTreeInfo.url) && Objects.equals(title, pageTreeInfo.title)
                && Objects.equals(nodes, pageTreeInfo.nodes);
    }

    @Override
    public int hashCode() {
        return Objects.hash(url, title, nodes);
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder();
        sb.append("class PageTreeInfo {\n");

        sb.append("    url: ").append(toIndentedString(url)).append("\n");
        sb.append("    title: ").append(toIndentedString(title)).append("\n");
        sb.append("    thirdOne: ").append(toIndentedString(thirdOne)).append("\n");
        //sb.append("    valid: ").append(toIndentedString(valid)).append("\n");
        sb.append("    nodes: ").append(toIndentedString(nodes)).append("\n");
        sb.append("}");
        return sb.toString();
    }

    /**
     * Convert the given object to string with each line indented by 4 spaces
     * (except the first line).
     */
    private String toIndentedString(final java.lang.Object o) {
        if (o == null) {
            return "null";
        }
        return o.toString().replace("\n", "\n    ");
    }
}
